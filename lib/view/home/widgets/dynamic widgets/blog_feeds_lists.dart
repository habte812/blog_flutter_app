import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/core/commen/feeds_list_card.dart';
import 'package:tech_node/core/custom/custom_bottom_loader.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/pagination/posted%20blogs/posted_blogs_state.dart';
import 'package:tech_node/data/viewModel/blog/blog_feed_notifier.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';
import 'package:tech_node/view/home/widgets/dynamic%20widgets/featured_4_grid_feeds.dart';
import 'package:tech_node/view/home/widgets/dynamic%20widgets/todays_featured_blogs_list.dart';

class BlogFeedsLists extends ConsumerWidget {
  const BlogFeedsLists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(blogFeedProvider);

    if (feedState.isLoading && feedState.items.isEmpty) {
      return const SliverToBoxAdapter(child: CustomShimmerLoading());
    }

    if (feedState.isFailure && feedState.items.isEmpty) {
      return SliverToBoxAdapter(
        child: CustomErrorNotifier(
          errorMessage: feedState.errorMessage ?? 'Something went wrong.',
          action: () => ref.read(blogFeedProvider.notifier).fetchFirstPage(),
        ),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        ..._buildLayoutSections(feedState),
        SliverToBoxAdapter(
          child: CustomBottomLoader(
            isLoadingMore: feedState.isLoadingMore,
            hasMorePages: feedState.hasMorePages,
            endTitle: "You've reached the end",
            isEmpty: feedState.items.isEmpty,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildLayoutSections(PostedBlogsState feedState) {
    if (!feedState.isLoading && feedState.items.isEmpty) {
      return [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: CustomTextStyle(
              textAlign: TextAlign.center,
              text: "No blogs found",
              fontSize: 14,
              textColor: Colors.white54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ];
    }

    final List<Widget> slivers = [];
    int consumedCount = 0;

    for (final instruction in feedState.layout) {
      final String type = instruction['type'];
      final int count = instruction['count'];

      final sectionItems = feedState.items
          .skip(consumedCount)
          .take(count)
          .toList();
      consumedCount += count;

      if (sectionItems.isEmpty) continue;

      switch (type) {
        case 'horizontal_trending':
          slivers.add(TodaysFeaturedBlogsList(blogModel: sectionItems));
          break;
        case 'gradient_hero':
          slivers.add(Featured4GridFeeds(blogModel: sectionItems));
          break;
        case 'standard_vertical':
          slivers.add(
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    FeedsListCard(blogModel: sectionItems[index]),
                childCount: sectionItems.length,
              ),
            ),
          );
          break;
        default:
          break;
      }
    }
    return slivers;
  }
}
