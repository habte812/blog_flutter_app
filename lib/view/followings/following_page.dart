import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/app/scroll_provider.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/blog/follow%20author/follow_notifier.dart';
import 'package:tech_node/view/followings/following_app_bar.dart';
import 'package:tech_node/view/followings/widgets/following%20blog/following_blogs_list.dart';
import 'package:tech_node/view/followings/widgets/guest/following_guest_page.dart';

class FollowingPage extends HookConsumerWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ScrollProvider.of(context).followingController;
    final authState = ref.watch(authProvider).status;

    if (authState == AuthStatus.unauthenticated) {
      return const FollowingGuestPage();
    } else if (authState == AuthStatus.error) {
      return const FollowingGuestPage();
    }else if (authState == AuthStatus.loading) {
      return const FollowingGuestPage();
    }
    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent * 0.85) {
            ref.read(myFollowingBlogsProvider.notifier).fetchMoreSaveds();
          }
          return true;
        },
        child: RefreshIndicator(
          displacement: 100,
          onRefresh: () async {
            await Future.wait([
              ref.read(myFollowingBlogsProvider.notifier).refreshThepage(),
              ref.read(getFollowingsProvider.notifier).refreshThePage(),
            ]);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            controller: controller,
            slivers: [
              const FollowingAppBar(),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              const SliverToBoxAdapter(child: FollowingBlogsList()),
            ],
          ),
        ),
      ),
    );
  }
}
