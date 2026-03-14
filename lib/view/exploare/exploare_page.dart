import 'package:flutter/material.dart';
import 'package:tech_node/app/scroll_provider.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/exploare/widgets/exploare_app_bar.dart';
import 'package:tech_node/view/exploare/widgets/top_searches.dart';
import 'package:tech_node/view/exploare/widgets/trending_categories.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollProvider.of(context).exploreController;
    return RefreshIndicator(
      color: primary,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: CustomScrollView(
        controller: controller,
        slivers: [
          ExploareAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Trending Categories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          TrendingCategories(),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomTextStyle(
                text: 'Top Searches',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TopSearches(),
          SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }
}
