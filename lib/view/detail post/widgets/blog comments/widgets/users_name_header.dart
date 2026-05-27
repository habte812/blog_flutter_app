import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/comment/blog_comment_model.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/comment_menu.dart';

class UsersNameHeader extends StatelessWidget {
  final BlogCommentModel comment;
  final int blogUserId;
  const UsersNameHeader({
    super.key,
    required this.comment,
    required this.blogUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      mainAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                CustomTextStyle(
                  text: comment.writer.name,
                  fontWeight: .w700,
                  fontSize: 13,
                  textColor: Colors.white.withValues(alpha: 0.9),
                ),
                if (comment.writer.userRole == 'admin' ||
                    comment.writer.userRole == 'author') ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.verified_sharp,
                    color: Color(0xff137fec),
                    size: 14,
                  ),
                ],
                if (blogUserId == comment.writer.id) ...[
                  const SizedBox(width: 4),
                  Container(
                    padding: const .symmetric(vertical: 2, horizontal: 6),
                    decoration: BoxDecoration(
                      color: context.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomTextStyle(
                      text: "Author",
                      textColor: context.primary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
            CustomTextStyle(
              text: comment.createdAt,
              fontSize: 11,
              textColor: Colors.white38,
            ),
          ],
        ),
        const Spacer(),
        CommentMenu(comment: comment),
      ],
    );
  }
}
