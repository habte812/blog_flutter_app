import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/providers/bool_keepalive_notifier.dart';
import 'package:tech_node/view/home/widgets/explore/explore_search_bar.dart';
import 'package:tech_node/view/home/widgets/profile_menu_lists.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(boolKeepaliveProvider('isSearching'));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSearching ? 0 : 40,
            child: Opacity(
              opacity: isSearching ? 0 : 1,
              child: const ProfileMenuLists(),
            ),
          ),

          Expanded(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: isSearching ? 0 : 10),
              child: ExploreSearchBar(
                isSearching: isSearching,
                onTap: () => ref
                    .read(boolKeepaliveProvider('isSearching').notifier)
                    .setTrue(),
                onClose: () => ref
                    .read(boolKeepaliveProvider('isSearching').notifier)
                    .toggle(),
              ),
            ),
          ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSearching ? 0 : 40,
            child: Opacity(
              opacity: isSearching ? 0 : 1,
              child: IconButton(
                padding: const .all(0),
                constraints: const BoxConstraints(),
                icon: const Icon(
                  LucideIcons.bell,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (!context.mounted) return;
                  context.push('/notification_page');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
