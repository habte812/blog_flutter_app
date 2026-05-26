import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/author/author_model.dart';
import 'package:tech_node/data/model/comment/blog_comment_model.dart';
import 'package:tech_node/data/repository/blog%20comments/comments_repository.dart';
import 'package:tech_node/data/viewModel/user/user_notifier.dart';

part 'comments_notifier.g.dart';

@riverpod
class CommentsNotifier extends _$CommentsNotifier {
  @override
  FutureOr<List<BlogCommentModel>> build(String postId) async {
    final keepMe = ref.keepAlive();
    Timer(const Duration(seconds: 30), () => keepMe.close());
    final repository = ref.read(commentsRepositoryProvider);
    return repository.getParentComments(postId: postId);
  }

  Future<void> refreshTheComment() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref
          .read(commentsRepositoryProvider)
          .getParentComments(postId: postId);
    });
  }

  Future<void> addComment({required String content, int? parentId}) async {
    final previousState = state.value ?? [];
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
        userRole: 'reader'
      ),
      postId: int.parse(postId),
      userId: currentUser?.id ?? 0,
      createdAt: '',
      updatedAt: '',
      totalReplies: 0,
      parentId: parentId,
    );
    if (parentId == null) {
      state = AsyncData([tempComment, ...previousState]);
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

      if (parentId == null) {
        if (state.hasValue) {
          state = AsyncData(
            state.value!.map((c) => c.id == tempId ? realComment : c).toList(),
          );
        }
      } else {
        ref
            .read(getcommentRepliesProvider(parentId).notifier)
            .finalizeReply(tempId, realComment);
        if (state.hasValue) {
          state = AsyncData(
            state.value!.map((c) {
              return c.id == parentId
                  ? c.copyWith(totalReplies: c.totalReplies + 1)
                  : c;
            }).toList(),
          );
        }
      }
    } catch (e, _) {
      if (parentId == null) {
        state = AsyncData(previousState);
      } else {
        ref.invalidate(getcommentRepliesProvider(parentId));
      }
    }
  }

  Future<void> deleteMyComment({required int commentId, int? parentId}) async {
    final previousParentState = state.value?.toList() ?? [];
    List<BlogCommentModel>? previousReplayState;

    if (parentId != null) {
      previousReplayState = ref.read(getcommentRepliesProvider(parentId)).value;
    }
    if (parentId == null) {
      state = AsyncData(
        state.value!.where((co) => co.id != commentId).toList(),
      );
    } else {
      final replynotifier = ref.read(
        getcommentRepliesProvider(parentId).notifier,
      );
      if (replynotifier.state.hasValue) {
        replynotifier.state = AsyncData(
          replynotifier.state.value!
              .where((com) => com.id != commentId)
              .toList(),
        );
      }
      if (state.hasValue) {
        state = AsyncData(
          state.value!.map((com) {
            return com.id == parentId
                ? com.copyWith(
                    totalReplies: (com.totalReplies - 1).clamp(0, 999),
                  )
                : com;
          }).toList(),
        );
      }
    }
    try {
      await ref
          .read(commentsRepositoryProvider)
          .deleteComment(commentId: commentId);
    } catch (e) {
      if (parentId == null) {
        state = AsyncData(previousParentState);
      } else {
        if (previousReplayState != null) {
          ref.read(getcommentRepliesProvider(parentId).notifier).state =
              AsyncData(previousReplayState);
        }
        state = AsyncData(previousParentState);
      }
      rethrow;
    }
  }
}

@riverpod
class GetcommentRepliesNotifier extends _$GetcommentRepliesNotifier {
  @override
  FutureOr<List<BlogCommentModel>> build(int parentId) async {
    final keepMe = ref.keepAlive();
    Timer(const Duration(seconds: 5), () => keepMe.close());
    return ref
        .read(commentsRepositoryProvider)
        .getRepliesComment(parentId: parentId.toString());
  }

  void addOptimisticReply(BlogCommentModel tempComment) {
    final previousData = state.value ?? [];
    state = AsyncData([...previousData, tempComment]);
  }

  void finalizeReply(int tempId, BlogCommentModel realComment) {
    if (state.hasValue) {
      state = AsyncData(
        state.value!.map((c) => c.id == tempId ? realComment : c).toList(),
      );
    }
  }
}
