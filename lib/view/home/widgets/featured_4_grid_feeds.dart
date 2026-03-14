import 'package:flutter/material.dart';
import 'package:tech_node/core/commen/featured_4_cards.dart';

class Featured4GridFeeds extends StatelessWidget {
  const Featured4GridFeeds({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GridView.builder(
        padding: .all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 10 / 16,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const Featured4Cards();
        },
      ),
    );
  }
}
