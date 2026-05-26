import 'package:flutter/material.dart';
import 'package:tech_node/app/scroll_provider.dart';
import 'package:tech_node/view/followings/widgets/guest/featured_authors.dart';
import 'package:tech_node/view/followings/widgets/guest/following_empty_state.dart';

class FollowingGuestPage extends StatelessWidget {
  const FollowingGuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollProvider.of(context).followingController;
    final mq = MediaQuery.of(context);
    final hPad = mq.size.width > 600 ? 48.0 : 20.0;
    return SafeArea(
      child: CustomScrollView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                EmptyStateSection(hPad: hPad),
                const SizedBox(height: 32),
                const FeaturedAuthors(),
                SizedBox(height: mq.padding.bottom + 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
