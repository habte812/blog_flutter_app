import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/custom/custom_bottom_loader.dart';
import 'package:tech_node/core/custom/custom_empty_state.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/data/viewModel/blog%20comments/comments_notifier.dart';
import 'package:tech_node/view/Library/widgets/saved_blogs_list.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/blog_comments_ui.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';

class CommentsList extends StatelessWidget {
  final String postId;
  final int blogUserId;
  const CommentsList({
    super.key,
    required this.postId,
    required this.blogUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(fetchBlogCommentsProvider(postId));
        if (state.isLoading && state.comments.isEmpty) {
          return const CustomCommentShimmerLoading();
        }
        if (state.isFailure && state.comments.isEmpty) {
          return CustomErrorNotifier(
            errorMessage: state.errorMessage ?? 'Something went wrong.',
            action: () => ref
                .read(fetchBlogCommentsProvider(postId).notifier)
                .firstFetchComments(),
          );
        }

        if (!state.isLoading && state.comments.isEmpty) {
          return Padding(
            padding: .only(top: MediaQuery.of(context).size.height * 0.1),
            child: const CustomEmptyState(
              description: "Be the first to comment!",
              title: "No comments yet",
              icon: Icons.comment,
            ),
          );
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              final metrics = notification.metrics;
              final atThreshold =
                  metrics.pixels >= metrics.maxScrollExtent * 0.85;
              if (atThreshold && !state.isLoadingMore && state.hasMorePages) {
                ref
                    .read(fetchBlogCommentsProvider(postId).notifier)
                    .fetchMoreComments();
              }
            }
            return false;
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverList.builder(
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  if (index >= state.comments.length) return null;
                  return BlogCommentsUi(
                    key: ValueKey(state.comments[index].id),
                    comment: state.comments[index],
                    blogUserId: blogUserId,
                  );
                },
              ),

              if (state.errorMessage != null &&
                  state.comments.isNotEmpty &&
                  !state.isLoadingMore)
                SliverToBoxAdapter(
                  child: InlineErrorBanner(
                    message: state.errorMessage!,
                    onRetry: () {},
                  ),
                ),
              SliverToBoxAdapter(
                child: CustomBottomLoader(
                  isLoadingMore: state.isLoadingMore,
                  hasMorePages: state.hasMorePages,
                  endTitle: 'You\'ve got all comments',
                  isEmpty: state.comments.isEmpty,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
