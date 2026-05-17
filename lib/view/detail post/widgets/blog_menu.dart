import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_bottom_sheet.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_show_dialog.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data%20local/local%20Models/offline_blogs_model.dart';
import 'package:tech_node/data%20local/viewModel/download%20Article/download_article_notifier.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';
import 'package:tech_node/data/viewModel/blog/blog%20detail/blog_detail_notifier.dart';
import 'package:tech_node/data/viewModel/ui/ui%20blog%20data/ui_data_provider.dart';
import 'package:tech_node/view/detail%20post/widgets/download_the_blog_image.dart';
import 'package:tech_node/view/detail%20post/widgets/menu%20methods/report/report_sheet_ui.dart';
import 'package:tech_node/view/detail%20post/widgets/menu%20methods/share%20post/share_post_to.dart';

class BlogMenu extends ConsumerWidget {
  final BlogsDetailModel blogDetail;
  const BlogMenu({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(deleteMyPublishedBlogProvider, (previous, next) {
      next.when(
        data: (value) {
          if (value == 'Deleted') {
            if (context.mounted) {
              Navigator.of(context).pop();
              CustomScaffoldMessage.show(
                context,
                message: "Blog deleted successfully",
              );
              context.go('/home');
            }
          } else {
            if (context.mounted) {
              Navigator.of(context).pop();
              CustomScaffoldMessage.show(context, message: value.toString());
            }
          }
        },
        error: (error, stackTrace) {
          Navigator.of(context).pop();
          CustomScaffoldMessage.show(context, message: error.toString());
        },
        loading: () {},
      );
    });
    ref.listen(downloadArticleProvider, (prev, nex) {
      nex.whenOrNull(
        data: (data) {
          CustomScaffoldMessage.show(
            context,
            message: "Downloaded successfully, you can read it in the Library",
          );
        },
        error: (e, _) {
          CustomScaffoldMessage.show(context, message: "$e", isError: true);
        },
      );
    });

    return PopupMenuButton<String>(
      tooltip: 'settings',
      elevation: 10,
      padding: const .all(0),
      offset: const Offset(0, 40),
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white10),
      ),
      icon: const SizedBox(
        child: Icon(LucideIcons.settings2, color: Colors.white),
      ),
      onSelected: (value) {
        if (value == 'share') {
          if (!context.mounted) return;
          SharePostTo.shareBlogPost(blogDetail);
        }
        if (value == 'report') {
          if (!context.mounted) return;
          CustomBottomSheet.show(
            context: context,
            child: ReportSheetUi(blogDetail: blogDetail),
          );
        }
        if (value == "edit") {
          ref.read(uiDataProviderProvider.notifier).setInitialData(blogDetail);
          if (!context.mounted) return;
          context.pushNamed('create');
        }
        if (blogDetail.previewDatas.thumbnail != null) {
          if (value == "download") {
            if (!context.mounted) return;
            DownloadTheBlogImage.startDownload(
              ref,
              blogDetail.previewDatas.thumbnail ?? '',
              context,
            );
          }
        }
        if (value == 'delete') {
          if (!context.mounted) return;
          customShowDialog(
            context,
            title: "Delete blog",
            subTitle: "Are you sure you want to delete this blog?",
            onCancel: () {},
            onRight: () {
              if (!context.mounted) return;
              ref
                  .read(deleteMyPublishedBlogProvider.notifier)
                  .deleteBlog(blogId: blogDetail.previewDatas.id);
            },
            rightButtonText: 'Delete',
            isLoading: () => ref.read(deleteMyPublishedBlogProvider).isLoading,
            cancelButtonText: "Cancel",
            icon: LucideIcons.trash2,
            iconColor: Colors.red,
          );
        }
        if (value == 'offline') {
          if (!context.mounted) return;
          ref
              .read(downloadArticleProvider.notifier)
              .startDownload(
                OfflineBlogsModel(
                  id: blogDetail.previewDatas.id,
                  title: blogDetail.previewDatas.title,
                  content: blogDetail.content,
                  thumbnail: blogDetail.previewDatas.thumbnail,
                  authorID: blogDetail.previewDatas.author.id,
                  categoryID: blogDetail.previewDatas.category.id,
                  categoryName: blogDetail.previewDatas.category.name,
                  viewCount: blogDetail.previewDatas.viewCount,
                  excerpt: blogDetail.previewDatas.excerpt,
                  authorImage: blogDetail.previewDatas.author.profilePicture,
                  authorName: blogDetail.previewDatas.author.name,
                  publishedAt: blogDetail.previewDatas.publishedAt,
                  updatedAt: blogDetail.previewDatas.updatedAt,
                  slug: blogDetail.slug,
                  shareCount: blogDetail.shareCount,
                ),
              );
        }
      },
      itemBuilder: (context) => [
        _buildPopupItem('Share', LucideIcons.share, 'share'),
        _buildPopupItem('Offline read', LucideIcons.wifiOff, 'offline'),
        if (blogDetail.previewDatas.thumbnail != null)
          _buildPopupItem('Download image', LucideIcons.download, 'download'),
        if (blogDetail.isOwner) ...[
          _buildPopupItem('Edit', LucideIcons.edit2, 'edit'),
          _buildPopupItem(
            'Delete',
            LucideIcons.trash,
            'delete',
            isDestructive: true,
          ),
        ],
        _buildPopupItem(
          'Report',
          Icons.report_problem_outlined,
          'report',
          isDestructive: true,
        ),
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
