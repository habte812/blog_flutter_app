import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/app/scroll_provider.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_banner_card.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/saved%20blogs/save_blog_notifier.dart';
import 'package:tech_node/view/Library/library_app_bar.dart';
import 'package:tech_node/view/Library/widgets/offline_blogs_list.dart';
import 'package:tech_node/view/Library/widgets/saved_blogs_list.dart';

class LibraryPage extends HookConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);
    final controller = ScrollProvider.of(context).libraryController;

    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authProvider).status;
        return SafeArea(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent * 0.85) {
                if (selectedTab.value == 0 &&
                    (authState == AuthStatus.authenticated ||
                        authState == AuthStatus.unverified)) {
                  ref.read(mySavedBlogsProvider.notifier).fetchMoreSaveds();
                }
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh:
                  selectedTab.value != 0 &&
                      authState == AuthStatus.unauthenticated
                  ? () async {}
                  : () async {
                      if ((authState == AuthStatus.authenticated ||
                          authState == AuthStatus.unverified)) {
                        await ref
                            .read(mySavedBlogsProvider.notifier)
                            .refreshThepage();
                      }
                    },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: controller,
                slivers: [
                  const LibraryAppBar(),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: PersistentHeaderDelegate(
                      extent: 55,
                      child: Container(
                        margin: const .symmetric(horizontal: 20),
                        height: 35,
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xff1c2733),
                          borderRadius: BorderRadius.only(
                            bottomLeft: .circular(15),
                            bottomRight: .circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildTab(0, "Favorites", selectedTab),
                            _buildTab(1, "Offline", selectedTab),
                          ],
                        ),
                      ),
                    ),
                  ),
                  selectedTab.value == 0
                      ? const SliverToBoxAdapter(child: SavedBlogsList())
                      : const SliverToBoxAdapter(child: OfflineBlogsList()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTab(int index, String label, ValueNotifier<int> selectedTab) {
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
            mainAxisAlignment: .center,
            children: [
              if (index == 0)
                Icon(
                  Icons.bookmark,
                  color: isSelected ? Colors.white : Colors.white38,
                  size: 20,
                ),
              if (index == 1)
                Icon(
                  Icons.wifi_off,
                  color: isSelected ? Colors.white : Colors.white38,
                  size: 20,
                ),
              const SizedBox(width: 8),
              CustomTextStyle(
                text: label,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                textColor: isSelected ? Colors.white : Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
