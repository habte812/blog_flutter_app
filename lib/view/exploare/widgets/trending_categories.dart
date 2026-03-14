import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';

class TrendingCategories extends StatelessWidget {
  const TrendingCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Sport',
      'Travel',
      'News',
      'Entertainment',
      'Job',
      'Technology',
    ];
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final category = categories[index];
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
                    child: Image.asset(
                      'assets/images/im${index + 1}.jpg',
                      fit: BoxFit.cover,
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
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }, childCount: 6),
      ),
    );
  }
}
