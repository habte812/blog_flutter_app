import 'package:flutter/material.dart';
import 'package:tech_node/app/scroll_provider.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_banner_card.dart';
import 'package:tech_node/view/home/widgets/featured_4_grid_feeds.dart';
import 'package:tech_node/view/home/widgets/home_app_bar.dart';
import 'package:tech_node/view/home/widgets/blog_feeds_lists.dart';
import 'package:tech_node/view/home/widgets/todays_featured_blogs_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollProvider.of(context).homeController;
    return RefreshIndicator(
      color: primary,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: CustomScrollView(
        controller: controller,
        slivers: [
          const SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            backgroundColor: background,
            expandedHeight: 72,
            collapsedHeight: 70,
            surfaceTintColor: background,
            automaticallyImplyLeading: false,

            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              expandedTitleScale: 1.0,
              title: HomeAppBar(),
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentBannerDelegate(child: const CustomBannerCard()),
          ),
          TodaysFeaturedBlogsList(),
          const Featured4GridFeeds(),
          const BlogFeedsLists(),
        ],
      ),
    );
  }
}
