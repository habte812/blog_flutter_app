// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/author/author_model.dart';
import 'package:tech_node/data/model/comment/blog_comment_model.dart';
import 'package:tech_node/data/model/pagination/comments/blog_comments_state.dart';
import 'package:tech_node/data/model/pagination/comments/comment_replies_state.dart';
import 'package:tech_node/data/model/pagination/paginated_response_model.dart';
import 'package:tech_node/data/repository/blog%20comments/comments_repository.dart';
import 'package:tech_node/data/viewModel/user/user_notifier.dart';

part 'comments_notifier.g.dart';

@riverpod
class GetcommentRepliesNotifier extends _$GetcommentRepliesNotifier {
  @override
  CommentRepliesState build(int parentId) {
    Future.microtask(() => firstFetchComments());
    return const CommentRepliesState();
  }

  Future<void> firstFetchComments({bool refresh = false}) async {
    if (state.isLoading) return;
    state = state.copyWith(
      status: PaginationStatus.loading,
      clearError: true,
      clearCursor: true,
      comments: refresh ? [] : state.comments,
    );
    try {
      final repo = ref.read(commentsRepositoryProvider);
      final bloComment = await repo.getRepliesComment(parentId: parentId);
      if (!ref.mounted) return;
      state = state.copyWith(
        comments: bloComment.data,
        nextCursor: bloComment.nextCursor,
        hasMorePages: bloComment.hasMorePages,
        status: PaginationStatus.success,
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchMoreComments() async {
    if (state.isLoadingMore ||
        !state.hasMorePages ||
        state.nextCursor == null) {
      return;
    }
    state = state.copyWith(status: PaginationStatus.loadingMore);

    try {
      final repo = ref.read(commentsRepositoryProvider);
      final bloComment = await repo.getRepliesComment(
        parentId: parentId,
        cursor: state.nextCursor,
      );
      if (!ref.mounted) return;
      state = state.copyWith(
        comments: [...state.comments, ...bloComment.data],
        nextCursor: bloComment.nextCursor,
        hasMorePages: bloComment.hasMorePages,
        status: PaginationStatus.success,
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refreshThepage() async {
    await firstFetchComments(refresh: true);
  }

  void addOptimisticReply(BlogCommentModel tempComment) {
    final previousData = state.comments;
    state = state.copyWith(comments: [...previousData, tempComment]);
  }

  void finalizeReply(int tempId, BlogCommentModel realComment) {
    state = state.copyWith(
      comments: state.comments
          .map((c) => c.id == tempId ? realComment : c)
          .toList(),
    );
  }

  void optimisticDeleteReply(int commentId) {
    state = state.copyWith(
      comments: state.comments.where((c) => c.id != commentId).toList(),
    );
  }

  void restoreComments(List<BlogCommentModel> backup) {
    state = state.copyWith(comments: backup);
  }
}

@riverpod
class FetchBlogCommentsNotifier extends _$FetchBlogCommentsNotifier {
  @override
  BlogCommentsState build(String postId) {
    Future.microtask(() => firstFetchComments());
    return const BlogCommentsState();
  }

  Future<void> firstFetchComments({bool refresh = false}) async {
    if (state.isLoading) return;
    state = state.copyWith(
      status: PaginationStatus.loading,
      clearError: true,
      clearCursor: true,
      comments: refresh ? [] : state.comments,
    );
    try {
      final repo = ref.read(commentsRepositoryProvider);
      final bloComment = await repo.getParentComments(postId: postId);
      if (!ref.mounted) return;
      state = state.copyWith(
        comments: bloComment.data,
        nextCursor: bloComment.nextCursor,
        hasMorePages: bloComment.hasMorePages,
        status: PaginationStatus.success,
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchMoreComments() async {
    if (state.isLoadingMore ||
        !state.hasMorePages ||
        state.nextCursor == null) {
      return;
    }
    state = state.copyWith(status: PaginationStatus.loadingMore);

    try {
      final repo = ref.read(commentsRepositoryProvider);
      final bloComment = await repo.getParentComments(
        postId: postId,
        cursor: state.nextCursor,
      );
      if (!ref.mounted) return;
      state = state.copyWith(
        comments: [...state.comments, ...bloComment.data],
        nextCursor: bloComment.nextCursor,
        hasMorePages: bloComment.hasMorePages,
        status: PaginationStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refreshThepage() async {
    await firstFetchComments(refresh: true);
  }

  Future<void> addComment({required String content, int? parentId}) async {
    final previousState = state.comments;
    final tempId = DateTime.now().millisecondsSinceEpoch;
    final currentUser = ref.read(userProvider).value;

    final tempComment = BlogCommentModel(
      id: tempId,
      content: content,
      writer: AuthorModel(
        id: currentUser?.id ?? 0,
        name: 'posting...',
        isFollowing: false,
        profilePicture: currentUser?.profileImage,
        userRole: 'reader',
      ),
      postId: int.parse(postId),
      userId: currentUser?.id ?? 0,
      createdAt: '',
      updatedAt: '',
      totalReplies: 0,
      parentId: parentId,
    );
    if (parentId == null) {
      state = state.copyWith(comments: [tempComment, ...previousState]);
    } else {
      ref
          .read(getcommentRepliesProvider(parentId).notifier)
          .addOptimisticReply(tempComment);
    }

    try {
      final realComment = await ref
          .read(commentsRepositoryProvider)
          .writeComment(
            postId: postId,
            content: content,
            parentId: parentId?.toString(),
          );
      if (!ref.mounted) return;
      if (parentId == null) {
        state = state.copyWith(
          comments: state.comments
              .map((c) => c.id == tempId ? realComment : c)
              .toList(),
        );
      } else {
        ref
            .read(getcommentRepliesProvider(parentId).notifier)
            .finalizeReply(tempId, realComment);
        state = state.copyWith(
          comments: state.comments.map((c) {
            return c.id == parentId
                ? c.copyWith(totalReplies: c.totalReplies + 1)
                : c;
          }).toList(),
        );
      }
    } catch (e, _) {
      if (!ref.mounted) return;
      if (parentId == null) {
        state = state.copyWith(
          comments: previousState,
          status: PaginationStatus.failure,
          errorMessage: e.toString(),
        );
      } else {
        ref.invalidate(getcommentRepliesProvider(parentId));
      }
    }
  }

  Future<void> deleteMyComment({required int commentId, int? parentId}) async {
    final previousParentState = state.comments.toList();
    List<BlogCommentModel>? previousReplayState;

    if (parentId != null) {
      previousReplayState = ref
          .read(getcommentRepliesProvider(parentId))
          .comments
          .toList();
    }
    if (parentId == null) {
      state = state.copyWith(
        comments: state.comments.where((co) => co.id != commentId).toList(),
      );
    } else {
      final replynotifier = ref.read(
        getcommentRepliesProvider(parentId).notifier,
      );

      replynotifier.optimisticDeleteReply(commentId);

      state = state.copyWith(
        comments: state.comments.map((com) {
          return com.id == parentId
              ? com.copyWith(totalReplies: (com.totalReplies - 1).clamp(0, 999))
              : com;
        }).toList(),
      );
    }
    try {
      await ref
          .read(commentsRepositoryProvider)
          .deleteComment(commentId: commentId);
    } catch (e) {
      if (!ref.mounted) return;
      if (parentId == null) {
        state = state.copyWith(
          comments: previousParentState,
          status: PaginationStatus.failure,
          errorMessage: e.toString(),
        );
      } else {
        if (previousReplayState != null) {
          ref
              .read(getcommentRepliesProvider(parentId).notifier)
              .restoreComments(previousReplayState);
        }
        state = state.copyWith(
          comments: previousParentState,
          status: PaginationStatus.failure,
        );
      }
    }
  }
}
