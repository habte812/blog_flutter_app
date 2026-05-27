import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/data/viewModel/blog%20comments/comments_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/comment_input_filed.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/comments_list.dart';

class CommentSheetUi extends StatelessWidget {
  final String postId;
  final int blogUserId;
  const CommentSheetUi({super.key, required this.postId, required this.blogUserId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            final addcomment = ref.watch(fetchBlogCommentsProvider(postId));
            return addcomment.isLoading
                ? const SizedBox(height: 1, child: CustomLineLoading())
                : const Divider(height: 1);
          },
        ),

        Expanded(child: CommentsList(postId: postId,blogUserId:blogUserId)),
        CommentInputField(postId: postId),
      ],
    );
  }
}
