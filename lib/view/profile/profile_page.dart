import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/notifier%20banner/notifier_banners.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/blog/my%20posted%20blogs/my_posted_blogs_notifier.dart';
import 'package:tech_node/data/viewModel/saved%20blogs/save_blog_notifier.dart';
import 'package:tech_node/view/Library/widgets/saved_blogs_list.dart';
import 'package:tech_node/view/profile/widgets/blog/draft_blogs.dart';
import 'package:tech_node/view/profile/widgets/blog/my_posted_blogs.dart';
import 'package:tech_node/view/profile/widgets/guest/guest_profile.dart';
import 'package:tech_node/view/profile/widgets/profile_bio_and_total.dart';
import 'package:tech_node/view/profile/widgets/profile_menu.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(1);
    final controller = useScrollController();

    final authState = ref.watch(authProvider).status;
    if (authState == AuthStatus.unauthenticated ||
        authState == AuthStatus.error ||
        authState == AuthStatus.loading) {
      return const GuestProfile();
    }

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent * 0.85) {
              if (authState == AuthStatus.authenticated ||
                  authState == AuthStatus.unverified) {
                if (selectedTab.value == 0) {
                } else if (selectedTab.value == 1) {
                  ref.read(myPostedBlogsProvider.notifier).fetchMorePosts();
                } else if (selectedTab.value == 2) {}
              }
            }
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () async {
              if (authState == AuthStatus.authenticated ||
                  authState == AuthStatus.unverified) {
                if (selectedTab.value == 1) {
                  await ref
                      .read(myPostedBlogsProvider.notifier)
                      .refreshThepage();
                } else if (selectedTab.value == 2) {
                  await ref
                      .read(mySavedBlogsProvider.notifier)
                      .refreshThepage();
                }
              }
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              controller: controller,
              slivers: [
                SliverAppBar(
                  expandedHeight: 280.0,
                  pinned: true,
                  stretch: true,
                  backgroundColor: background,
                  surfaceTintColor: background,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(color: context.primary),
                        ),
                        const ProfileBioAndTotal(),
                      ],
                    ),
                  ),
                  actions: [const ProfileMenu()],
                ),

                const SliverPadding(
                  padding: EdgeInsets.all(10),
                  sliver: NotifierBanner(),
                ),

                if (authState != AuthStatus.unverified) ...[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      extent: 55,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xff1c2733),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            _buildTab(
                              0,
                              LucideIcons.pencil,
                              'Draft',
                              selectedTab,
                            ),
                            _buildTab(
                              1,
                              LucideIcons.layoutGrid,
                              'Posted',
                              selectedTab,
                            ),
                            _buildTab(
                              2,
                              LucideIcons.bookmark,
                              'Saved',
                              selectedTab,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (selectedTab.value == 0)
                    const SliverToBoxAdapter(child: DraftBlogs())
                  else if (selectedTab.value == 1)
                    const SliverToBoxAdapter(child: MyPostedBlogs())
                  else
                    const SliverToBoxAdapter(child: SavedBlogsList()),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(
    int index,
    IconData icon,
    String label,
    ValueNotifier<int> selectedTab,
  ) {
    final bool isSelected = selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          selectedTab.value = index;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: isSelected ? background : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white38,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.white38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom fixed-extent delegate replacement for your older tab-bar layouts
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.extent, required this.child});

  final double extent;
  final Widget child;

  @override
  double get minExtent => extent;
  @override
  double get maxExtent => extent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: background,
      height: extent,
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate.extent != extent || oldDelegate.child != child;
  }
}
