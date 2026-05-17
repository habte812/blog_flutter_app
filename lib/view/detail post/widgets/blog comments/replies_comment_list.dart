import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/data/model/comment/blog_comment_model.dart';
import 'package:tech_node/data/viewModel/blog%20comments/comments_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/blog_comments_ui.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/provider/expande_replies_notifier.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';

class RepliesCommentList extends StatelessWidget {
  final BlogCommentModel comment;
  const RepliesCommentList({super.key, required this.comment});

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

        final replies = ref.watch(getcommentRepliesProvider(comment.id));
        return replies.when(
          loading: () => const Center(
            child: SizedBox(height: 50, width: 50, child: CustomLoading()),
          ),
          error: (error, stackTrace) => Center(
            child: CustomErrorNotifier(
              action: () {},
              errorMessage: error.toString(),
            ),
          ),
          data: (data) {
            return Padding(
              padding: const .only(left: 25.0),
              child: Container(
                padding: const .symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return BlogCommentsUi(comment: data[index], depth: 1);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
