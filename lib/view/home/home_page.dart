import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/app/scroll_provider.dart';
import 'package:tech_node/core/commen/notifier%20banner/notifier_banners.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_banner_card.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/blog/blog_feed_notifier.dart';
import 'package:tech_node/view/home/widgets/home_app_bar.dart';
import 'package:tech_node/view/home/widgets/dynamic%20widgets/blog_feeds_lists.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollProvider.of(context).homeController;
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authProvider).status;
        final feedState = ref.watch(blogFeedProvider);

        return RefreshIndicator(
          displacement: 100,
          color: context.primary,
          onRefresh: () async {
            await Future.wait([
              ref.read(blogFeedProvider.notifier).refreshThepage(),
              if(authState != AuthStatus.unauthenticated)
              ref.read(authProvider.notifier).refreshUserstatus(),
            ]);
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                final metrics = notification.metrics;
                final atThreshold =
                    metrics.pixels >= metrics.maxScrollExtent * 0.85;
                if (atThreshold &&
                    !feedState.isLoadingMore &&
                    feedState.hasMorePages) {
                  ref.read(blogFeedProvider.notifier).fetchMorePosts();
                }
              }
              return false;
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
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
                if (authState == AuthStatus.loading)
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: PersistentHeaderDelegate(
                      extent: 3,
                      child: const CustomLineLoading(),
                    ),
                  ),
                const NotifierBanner(),
                const BlogFeedsLists(),
              ],
            ),
          ),
        );
      },
    );
  }
}
