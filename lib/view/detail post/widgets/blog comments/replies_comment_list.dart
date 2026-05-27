import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_bottom_loader.dart';
import 'package:tech_node/core/custom/custom_empty_state.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/data/model/comment/blog_comment_model.dart';
import 'package:tech_node/data/viewModel/blog%20comments/comments_notifier.dart';
import 'package:tech_node/view/Library/widgets/saved_blogs_list.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/blog_comments_ui.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/provider/expande_replies_notifier.dart';

class RepliesCommentList extends StatelessWidget {
  final BlogCommentModel comment;
  final int blogUserId;
  const RepliesCommentList({super.key, required this.comment, required this.blogUserId});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isExpanded = ref.watch(
          expandeRepliesProvider(comment.id.toString()),
        );
        if (!isExpanded) {
          return const SizedBox.shrink();
        }
        final state = ref.watch(getcommentRepliesProvider(comment.id));
        if (state.isLoading && state.comments.isEmpty) {
          return const Center(
            child: SizedBox(height: 50, width: 50, child: CustomLoading()),
          );
        }
        if (state.isFailure && state.comments.isEmpty) {
          return CustomErrorNotifier(
            errorMessage: state.errorMessage ?? 'Something went wrong.',
            action: () => ref
                .read(getcommentRepliesProvider(comment.id).notifier)
                .firstFetchComments(),
          );
        }
        if (!state.isLoading && state.comments.isEmpty) {
          Padding(
            padding: .only(top: MediaQuery.of(context).size.height * 0.12),
            child: const CustomEmptyState(
              description: "No replies yet. Be the first to reply!",
              title: "No replies yet",
              icon: Icons.comment,
            ),
          );
        }
        return Column(
          children: [
            Container(
              margin: const .only(left: 25),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  return BlogCommentsUi(
                    comment: state.comments[index],
                    depth: 1,
                    blogUserId:blogUserId
                  );
                },
              ),
            ),

            if (state.errorMessage != null &&
                state.comments.isNotEmpty &&
                !state.isLoadingMore)
              InlineErrorBanner(message: state.errorMessage!, onRetry: () {}),
            Row(
              mainAxisAlignment: .center,
              children: [
                CustomBottomLoader(
                  loaderSize: const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CustomLoading(),
                    ),
                  ),
                  isLoadingMore: state.isLoadingMore,
                  hasMorePages: state.hasMorePages,
                  endTitle: 'You\'ve got all replies',
                  isEmpty: state.comments.isEmpty,
                ),
                if (!state.hasMorePages && state.comments.isNotEmpty) ...[
                  const SizedBox(width: 6),
                  ActionButton(
                    textColor: context.primary.withValues(alpha: 0.9),
                    label: "Close all",
                    icon: LucideIcons.arrowUp,
                    onTap: () => ref
                        .read(
                          expandeRepliesProvider(
                            comment.id.toString(),
                          ).notifier,
                        )
                        .toggle(),
                  ),
                ],
              ],
            ),
            if (!state.isLoadingMore &&
                state.comments.isNotEmpty &&
                state.hasMorePages)
              ActionButton(
                textColor: context.primary.withValues(alpha: 0.9),
                label: "Show more",
                icon: LucideIcons.arrowDown,
                onTap: () => ref
                    .read(getcommentRepliesProvider(comment.id).notifier)
                    .fetchMoreComments(),
              ),
          ],
        );
      },
    );
  }
}
