import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/user/user_notifier.dart';

class ProfileMenuLists extends ConsumerWidget {
  const ProfileMenuLists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).status;
    ref.listen(authProvider, (previous, next) {
      if (next.status == AuthStatus.error) {
        CustomScaffoldMessage.show(
          context,
          message: next.errorMessage ?? 'Error logging out',
          isError: true,
        );
      } else if (next.status == AuthStatus.unauthenticated) {}
    });
    return PopupMenuButton<String>(
      tooltip: 'Profile',
      color: background.withValues(alpha: 0.95),
      elevation: 10,
      padding: const .all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white10),
      ),
      offset: const Offset(0, 50),
      icon:
          // authState == AuthStatus.unauthenticated
          //     ?
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.primary.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: background,
              child: Icon(LucideIcons.user, size: 18, color: Colors.white),
            ),
          ),
      // : userProfile.when(
      //     loading: () =>
      //         const SizedBox(height: 50, width: 50, child: CustomLoading()),
      //     error: (error, stackTrace) => IconButton(
      //       padding: .zero,
      //       onPressed: () {
      //         ref.read(userProvider.notifier).refreshProfile();
      //       },
      //       icon: const Icon(Icons.refresh),
      //     ),
      //     data: (data) {
      //       return Container(
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           border: Border.all(
      //             color: primary.withValues(alpha: 0.5),
      //             width: 2,
      //           ),
      //         ),
      //         child:
      //             authState == AuthStatus.unauthenticated ||
      //                 data.profileImage != null
      //             ? ClipRRect(
      //                 borderRadius: .circular(18),
      //                 child: CircleAvatar(
      //                   radius: 18,
      //                   child: CachedNetworkImage(
      //                     fit: BoxFit.cover,
      //                     imageUrl: data.profileImage!,
      //                     placeholder: (context, url) => const Center(
      //                       child: Icon(
      //                         LucideIcons.user,
      //                         color: Colors.white54,
      //                         size: 18,
      //                       ),
      //                     ),
      //                     errorWidget: (context, url, error) =>
      //                         const Center(
      //                           child: Icon(
      //                             LucideIcons.user,
      //                             color: Colors.redAccent,
      //                             size: 18,
      //                           ),
      //                         ),
      //                   ),
      //                 ),
      //               )
      //             : const CircleAvatar(
      //                 radius: 18,
      //                 backgroundColor: background,
      //                 child: Icon(
      //                   LucideIcons.user,
      //                   size: 18,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //       );
      //     },
      //   ),
      onSelected: (value) {
        if (value == 'profile') {
          if (!context.mounted) return;
          context.pushNamed('profile');
        }
        if (value == 'logout') {
          if (!context.mounted) return;
          ref.read(authProvider.notifier).logout();
          ref.read(userProvider.notifier).refreshProfile();
        }
      },
      itemBuilder: (context) => [
        _buildPopupItem('Profile', LucideIcons.user, 'profile'),
        if (authState == AuthStatus.authenticated ||
            authState == AuthStatus.unverified) ...[
          // _buildPopupItem('Share', LucideIcons.share2, 'share'),
          const PopupMenuDivider(height: 1),
          _buildPopupItem(
            'Log out',
            LucideIcons.logOut,
            'logout',
            isDestructive: true,
          ),
        ],
      ],
    );
  }
}

PopupMenuItem<String> _buildPopupItem(
  String title,
  IconData icon,
  String value, {
  bool isDestructive = false,
}) {
  return PopupMenuItem(
    value: value,
    child: Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDestructive ? Colors.redAccent : Colors.white70,
        ),
        const SizedBox(width: 12),
        CustomTextStyle(
          text: title,
          fontSize: 14,
          textColor: isDestructive ? Colors.redAccent : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ],
    ),
  );
}
