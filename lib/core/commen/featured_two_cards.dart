import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/blog/blogs_preview_model.dart';
import 'package:tech_node/data/viewModel/blog/blog%20detail/blog_detail_notifier.dart';

class FeaturedTwoCards extends ConsumerWidget {
  final BlogsPreviewModel blogModel;
  const FeaturedTwoCards({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: card,
        highlightColor: card,
        onTap: () {
          if (!context.mounted) return;
          context.push('/detail-posts/${blogModel.id}/${blogModel.author.id}');
          ref.read(addBlogViewProvider(id: blogModel.id.toString()));
        },
        child: Container(
          clipBehavior: .antiAlias,
          decoration: BoxDecoration(color: card, borderRadius: .circular(10)),
          child: Stack(
            children: [
              if (blogModel.thumbnail != null)
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: blogModel.thumbnail!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CustomLoading()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: .circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.9),
                      ],
                      stops: const [0.4, 1.0],
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
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomTextStyle(
                    text: blogModel.category.name,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const .only(left: 16, bottom: 16, right: 30),
                child: Align(
                  alignment: .bottomLeft,
                  child: CustomTextStyle(
                    text: blogModel.title,
                    fontSize: 15,
                    maxLine: 2,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
