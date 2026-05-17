import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/comment/blog_comment_model.dart';
import 'package:tech_node/data/viewModel/blog%20comments/comments_notifier.dart';

class CommentMenu extends ConsumerWidget {
  final BlogCommentModel comment;
  const CommentMenu({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(commentsProvider(comment.id.toString()), (prev, nex) {
      if (prev is AsyncData && nex is AsyncError) {
        CustomScaffoldMessage.show(
          context,
          message: nex.error.toString(),
          isError: true,
        );
      }
    });
    return PopupMenuButton<String>(
      tooltip: 'menu',
      color: background.withValues(alpha: 1),
      elevation: 0,
      iconSize: 18,
      padding: const .all(0),
      menuPadding: .zero,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(10),
        side: const BorderSide(color: Colors.white10),
      ),
      offset: const Offset(0, 50),
      icon: const Icon(
        LucideIcons.moreVertical,
        color: Colors.white54,
        size: 18,
      ),
      onSelected: (value) {
        if (!context.mounted) return;
        if (value == "delete") {
          ref
              .read(commentsProvider(comment.postId.toString()).notifier)
              .deleteMyComment(
                commentId: comment.id,
                parentId: comment.parentId,
              );
          debugPrint("------------------->>>>>>>>>>>>>>> ${comment.parentId}");
        }
      },
      itemBuilder: (context) => [
        _buildPopupItem('Delete', LucideIcons.trash, 'delete'),
        _buildPopupItem('Report', LucideIcons.flag, 'report'),
      ],
    );
  }
}

PopupMenuItem<String> _buildPopupItem(
  String title,
  IconData icon,
  String value, {
  bool isDestructive = false,
}) {
  return PopupMenuItem(
    value: value,
    child: Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDestructive ? Colors.redAccent : Colors.white70,
        ),
        const SizedBox(width: 12),
        CustomTextStyle(
          text: title,
          fontSize: 14,
          textColor: isDestructive ? Colors.redAccent : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ],
    ),
  );
}
