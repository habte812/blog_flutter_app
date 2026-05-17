import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/viewModel/blog%20comments/comments_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/blog_comments_ui.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';

class CommentsList extends ConsumerWidget {
  final String postId;
  const CommentsList({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(commentsProvider(postId));
    return commentsAsync.when(
      loading: () => const CustomCommentShimmerLoading(),
      error: (err, stack) => CustomErrorNotifier(
        action: () =>
            ref.read(commentsProvider(postId).notifier).refreshTheComment(),
        errorMessage: err.toString(),
      ),
      data: (comments) {
        if (comments.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,
              children: [
                const CustomTextStyle(
                  text: "No comments yet. Be the first!",
                  fontSize: 14,
                  fontWeight: .bold,
                  textAlign: .center,
                ),
                const SizedBox(height: 6),
                TextButton(
                  style:  ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(context.primary),
                  ),
                  onPressed: () {},
                  child: const CustomTextStyle(
                    text: 'Write Comment',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return BlogCommentsUi(
              key: ValueKey(comments[index].id),
              comment: comments[index],
            );
          },
        );
      },
    );
  }
}
