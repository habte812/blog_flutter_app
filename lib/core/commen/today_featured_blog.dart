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

class TodayFeaturedBlog extends ConsumerWidget {
  final BlogsPreviewModel blogModel;
  const TodayFeaturedBlog({super.key, required this.blogModel});

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
        child: SizedBox(
          width: 360,
          child: Padding(
            padding: const .all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                if (blogModel.thumbnail != null)
                  Stack(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: card,
                          borderRadius: BorderRadius.circular(6),
                        ),

                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: .circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: blogModel.thumbnail!,
                              placeholder: (context, url) =>
                                  const Center(child: CustomLoading()),
                              // const Center(
                              //   child: Icon(
                              //     LucideIcons.image,
                              //     color: Colors.white54,
                              //   ),
                              // ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                    child: Icon(
                                      LucideIcons.imageOff,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const .only(top: 8, right: 8),
                          padding: const .symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: context.primary,
                            borderRadius: .circular(6),
                          ),
                          child: CustomTextStyle(
                            text: blogModel.category.name,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 5),
                CustomTextStyle(
                  text: blogModel.title,
                  fontSize: 18,
                  maxLine: 2,
                  overflow: .ellipsis,
                  fontWeight: .bold,
                ),
                const SizedBox(height: 8),

                CustomTextStyle(
                  text: blogModel.excerpt,
                  fontSize: 14,
                  maxLine: 2,
                  overflow: .ellipsis,
                  textColor: Colors.white70,
                ),
                const Spacer(),
                CommonAuthorProfile(radius: 16, blogModel: blogModel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
