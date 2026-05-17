import 'package:flutter/material.dart';
import 'package:tech_node/core/commen/featured_two_cards.dart';
import 'package:tech_node/data/model/blog/blogs_preview_model.dart';

class Featured4GridFeeds extends StatelessWidget {
  final List<BlogsPreviewModel> blogModel;
  const Featured4GridFeeds({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GridView.builder(
        padding: const .all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 10 / 16,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: blogModel.length,
        itemBuilder: (context, index) {
          return FeaturedTwoCards(blogModel: blogModel[index]);
        },
      ),
    );
  }
}
