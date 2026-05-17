import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/viewModel/category/categories_notifier.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';

class TrendingCategories extends StatelessWidget {
  const TrendingCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final categories = ref.watch(categoriesProvider);
        return categories.when(
          loading: () => const TrendingCategoryShimmer(),
          error: (err, _) => SliverToBoxAdapter(
            child: CustomErrorNotifier(
              action: () async=> await ref.read(categoriesProvider.notifier).refreshTheCategory(),
              errorMessage: err.toString(),
            ),
          ),
          data: (data) {
            return SliverPadding(
              padding: const .symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: data.length > 6 ? 6 : data.length,
                  (context, index) {
                    final category = data[index];
                    return GestureDetector(
                      onTap: () => context.pushNamed('search'),
                      child: Container(
                        clipBehavior: .antiAlias,
                        decoration: BoxDecoration(
                          color: card,
                          borderRadius: .circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: .circular(6),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: category.categoryImage,
                                  placeholder: (context, url) => const Center(
                                    child: Icon(
                                      LucideIcons.image,
                                      color: Colors.white54,
                                    ),
                                  ),
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
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: .circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      // Colors.transparent,
                                      Colors.black.withValues(alpha: 0.5),
                                      Colors.black.withValues(alpha: 0.5),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: CustomTextStyle(
                                text: category.name,
                                fontSize: 14,
                                textColor: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
