import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';
import 'package:tech_node/data/viewModel/download/download_image_progress.dart';

class BlogThumbnail extends ConsumerWidget {
  final BlogsDetailModel blogDetail;
  const BlogThumbnail({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (blogDetail.previewDatas.thumbnail == null) {
      return const SizedBox.shrink();
    }
    final progress = ref.watch(
      downloadProgressNotifier(blogDetail.previewDatas.thumbnail ?? ''),
    );
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: blogDetail.previewDatas.thumbnail!,
            placeholder: (context, url) => const Center(
              child: Icon(LucideIcons.image, color: Colors.white54),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(LucideIcons.imageOff, color: Colors.redAccent),
            ),
          ),
        ),
        if (progress > 0 && progress < 1)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black45,
              child: Stack(
                alignment: .center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 4,
                      backgroundColor: Colors.white24,
                      valueColor:  AlwaysStoppedAnimation<Color>(
                        context.primary,
                      ),
                    ),
                  ),
                  CustomTextStyle(
                    text: "${(progress * 100).toInt()}%",
                    fontSize: 12,
                    fontWeight: .bold,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
