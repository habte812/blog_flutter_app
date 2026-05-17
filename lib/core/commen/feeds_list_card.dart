import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/widgets/common_author_profile.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/blog/blogs_preview_model.dart';
import 'package:tech_node/data/viewModel/blog/blog%20detail/blog_detail_notifier.dart';

class FeedsListCard extends ConsumerWidget {
  final BlogsPreviewModel blogModel;
  const FeedsListCard({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: card,
        highlightColor: card,
        onTap: () {
          if (!context.mounted) return;
          context.push('/detail-posts/${blogModel.id}');
          ref.read(addBlogViewProvider(id: blogModel.id.toString()));
        },
        child: Container(
          height: 144,
          margin: const .only(left: 16, right: 16, top: 5, bottom: 10),
          padding: const .all(12),
          child: Row(
            children: [
              if (blogModel.thumbnail != null)
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: .circular(6),
                    child: CachedNetworkImage(
                      height: 138,
                      width: 138,
                      fit: BoxFit.cover,
                      imageUrl: blogModel.thumbnail!,
                      placeholder: (context, url) =>
                          const Center(child: CustomLoading()),
                      // const Center(
                      //   child: Icon(LucideIcons.image, color: Colors.white54),
                      // ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          LucideIcons.imageOff,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      padding: const .symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white70.withValues(alpha: 0.06),
                        borderRadius: .circular(6),
                      ),
                      child: CustomTextStyle(
                        text: blogModel.category.name,
                        fontSize: 11,
                        textColor: context.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextStyle(
                      text: blogModel.title,
                      fontSize: 16,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    CommonAuthorProfile(radius: 10, blogModel: blogModel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
