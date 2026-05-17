import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_show_dialog.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data%20local/local%20Models/offline_blogs_model.dart';
import 'package:tech_node/data%20local/viewModel/download%20Article/download_article_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/menu%20methods/share%20post/share_post_to.dart';

class OfflineAppBar extends ConsumerWidget {
  final OfflineBlogsModel blogDetail;
  const OfflineAppBar({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(deleteTheOfflineBlogProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (!context.mounted) return;
          CustomScaffoldMessage.show(context, message: "removed successfully");
          ref.invalidate(getListsOfDownloadedProvider);
          context.pop();
        },
        error: (error, _) {
          if (!context.mounted) return;
          CustomScaffoldMessage.show(context, message: error.toString());
        },
      );
    });
    return Container(
      color: background,
      child: Row(
        children: [
          IconButton(
            highlightColor: background,
            splashColor: background,
            onPressed: () {
              if (!context.mounted) return;
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          ),
          Expanded(
            child: CustomTextStyle(
              text: blogDetail.title,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              maxLine: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () {
              if (!context.mounted) return;
              SharePostTo.shareOfflineBlog(blogDetail);
            },
            icon: const Icon(LucideIcons.share),
          ),
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                highlightColor: background,
                onPressed: () async {
                  if (!context.mounted) return;
                  customShowDialog(
                    context,
                    title: "Remove blog",
                    subTitle: "Are you sure you want to remove this blog?",
                    onCancel: () {},
                    onRight: () {
                      if (!context.mounted) return;
                      ref
                          .read(deleteTheOfflineBlogProvider.notifier)
                          .deleteBlog(blogDetail.id);
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    rightButtonText: 'Remove',
                    isLoading: () =>
                        ref.watch(deleteTheOfflineBlogProvider).isLoading,
                    cancelButtonText: "Cancel",
                    icon: LucideIcons.trash2,
                    iconColor: Colors.red,
                  );
                },
                icon: const Icon(
                  LucideIcons.trash,
                  color: Colors.redAccent,
                  size: 28,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
