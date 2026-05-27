import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/comment/blog_comment_model.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/provider/active%20reply/active_reply_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/provider/expande_replies_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/replies_comment_list.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/widgets/users_name_header.dart';

class BlogCommentsUi extends StatelessWidget {
  final BlogCommentModel comment;
  final int depth;
  final int blogUserId;
  const BlogCommentsUi({
    super.key,
    required this.comment,
    this.depth = 0,
    required this.blogUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: depth > 0 ? 5 : 0, bottom: 4),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: .start,
              children: [
                _buildAvatar(context),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      UsersNameHeader(comment: comment, blogUserId: blogUserId),
                      _buildCommentBody(),
                      const SizedBox(height: 12),
                      _buildActionRow(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          RepliesCommentList(comment: comment, blogUserId: blogUserId),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/author-profile/${comment.writer.id}/'),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white10, width: 1),
        ),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: card,
          backgroundImage: comment.writer.profilePicture != null
              ? NetworkImage(comment.writer.profilePicture!)
              : null,
          child: comment.writer.profilePicture == null
              ? const Icon(Icons.person, size: 18, color: Colors.white54)
              : null,
        ),
      ),
    );
  }

  Widget _buildCommentBody() {
    return Consumer(
      builder: (context, ref, child) {
        final isExpanded = ref.watch(
          expandeRepliesProvider('commentContent${comment.id}'),
        );
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ref
                  .read(
                    expandeRepliesProvider(
                      'commentContent${comment.id}',
                    ).notifier,
                  )
                  .toggle();
            },
            onLongPress: () async {
              await Clipboard.setData(
                ClipboardData(
                  text:
                      "@${comment.writer.name.replaceAll(' ', '_')}: ${comment.content}",
                ),
              );
              if (context.mounted) {
                CustomScaffoldMessage.show(context, message: 'Copied');
              }
            },
            child: CustomTextStyle(
              text: comment.content,
              textColor: Colors.white.withValues(alpha: 0.85),
              fontSize: 14,
              maxLine: isExpanded ? null : 5,
              overflow: isExpanded ? null : .ellipsis,
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionRow() {
    return Consumer(
      builder: (context, ref, child) {
        final isExpanded = ref.watch(
          expandeRepliesProvider(comment.id.toString()),
        );

        return Wrap(
          spacing: 20,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (depth == 0)
              ActionButton(
                label: "Reply",
                icon: LucideIcons.messageSquare,
                onTap: () => ref
                    .read(activeReplyProvider.notifier)
                    .setReply(comment.id, comment.writer.name),
              ),

            if (comment.totalReplies > 0)
              ActionButton(
                textColor: context.primary.withValues(alpha: 0.9),
                icon: isExpanded
                    ? LucideIcons.chevronUp
                    : LucideIcons.chevronDown,
                label:
                    "${comment.totalReplies} ${comment.totalReplies == 1 ? 'reply' : 'replies'}",
                onTap: () {
                  ref
                      .read(
                        expandeRepliesProvider(comment.id.toString()).notifier,
                      )
                      .toggle();
                },
              ),
          ],
        );
      },
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? textColor;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: .min,
          children: [
            Icon(icon, size: 14, color: textColor ?? Colors.white38),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: textColor ?? Colors.white38,
                fontSize: 12,
                fontWeight: .w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
