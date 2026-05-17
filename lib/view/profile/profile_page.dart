import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/notifier%20banner/notifier_banners.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/user/user_notifier.dart';
import 'package:tech_node/view/Library/widgets/saved_blogs_list.dart';
import 'package:tech_node/view/profile/widgets/blog/draft_blogs.dart';
import 'package:tech_node/view/profile/widgets/blog/my_posted_blogs.dart';
import 'package:tech_node/view/profile/widgets/profile_bio_and_total.dart';
import 'package:tech_node/view/profile/widgets/profile_menu.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: background,
      body: RefreshIndicator(
        displacement: 100,
        onRefresh: () async =>
            await ref.read(userProvider.notifier).refreshProfile(),
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight:
                      280.0, // Increased for better visual breathing room
                  pinned: true,
                  stretch: true,
                  backgroundColor: background,
                  surfaceTintColor: background,
                  // Glassmorphism effect when scrolled
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.primary,
                            // gradient: LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            //   colors: [context.primary, background],
                            // ),
                          ),
                        ),
                        const ProfileBioAndTotal(),
                      ],
                    ),
                  ),
                  actions: [const ProfileMenu()],
                ),

                const SliverPadding(
                  padding: .all(10),
                  sliver: NotifierBanner(),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final authState = ref.watch(authProvider).status;
                    if (authState != AuthStatus.unauthenticated &&
                        authState != AuthStatus.unverified) {
                      return SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          TabBar(
                            dividerColor: Colors.white.withValues(alpha: 0.05),
                            indicatorColor: context.primary,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorWeight: 3,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                            labelColor: context.primary,
                            unselectedLabelColor: Colors.white38,
                            tabs: [
                              _buildTab(LucideIcons.pencil, 'Draft'),
                              _buildTab(LucideIcons.layoutGrid, 'Posted'),
                              _buildTab(LucideIcons.bookmark, 'Saved'),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
              ];
            },
            body: Consumer(
              builder: (context, ref, child) {
                final authState = ref.watch(authProvider).status;
                if (authState != AuthStatus.unauthenticated &&
                    authState != AuthStatus.unverified) {
                  return const TabBarView(
                    children: [DraftBlogs(), MyPostedBlogs(), SavedBlogsList()],
                  );
                }
                return const Center(
                  child: CustomTextStyle(text: "Please login to view profile"),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String label) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 16), const SizedBox(width: 8), Text(label)],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: background,
      height: _tabBar.preferredSize.height,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
