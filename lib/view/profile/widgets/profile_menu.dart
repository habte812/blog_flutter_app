import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/user/user_notifier.dart';
import 'package:tech_node/core/commen/widgets/share%20profile/share_profile.dart';

class ProfileMenu extends ConsumerWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).status;
    final userProfile = ref.watch(userProvider);
    if (authState == AuthStatus.unauthenticated) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        IconButton(
          icon: const Icon(LucideIcons.edit2, color: Colors.white),
          onPressed: () {
            if (!context.mounted) return;
            context.pushNamed('edit_profile');
          },
        ),
        IconButton(
          icon: const Icon(LucideIcons.share, color: Colors.white),
          onPressed: () {
            if (!context.mounted) return;
            userProfile.when(
              data: (data) {
                return ShareProfile.shareAuthorProfile(
                  data.id.toString(),
                  data.userName,
                );
              },
              error: (error, stackTrace) => const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }
}

