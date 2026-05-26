import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/user/user_notifier.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';

class ProfileBioAndTotal extends ConsumerWidget {
  const ProfileBioAndTotal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).status;
    if (authState == AuthStatus.unauthenticated) {
      return const SafeArea(
        child: Center(
          child: CustomTextStyle(
            text: 'Login to see your profile',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else if (authState == AuthStatus.error) {
      return const SafeArea(
        child: Center(
          child: CustomTextStyle(
            text: 'Error loading profile',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Consumer(
      builder: (context, ref, child) {
        final userData = ref.watch(userProvider);
        return SafeArea(
          child: userData.when(
            loading: () => const CustomUserProfileShimmer(),
            error: (error, stackTrace) => CustomErrorNotifier(
              action: () => ref.read(userProvider.notifier).refreshProfile(),
              errorMessage: error.toString(),
              textColor: Colors.white,
            ),
            data: (user) {
              return Center(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: .circular(45),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: card,
                        child: user.profileImage == null
                            ? const Icon(
                                LucideIcons.user,
                                color: Colors.white54,
                                size: 45,
                              )
                            : CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: user.profileImage!,
                                placeholder: (context, url) => const Center(
                                  child: Icon(
                                    LucideIcons.user,
                                    color: Colors.white54,
                                    size: 45,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                      child: Icon(
                                        LucideIcons.user,
                                        color: Colors.redAccent,
                                        size: 45,
                                      ),
                                    ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextStyle(
                      text: user.userName,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    if (user.userBio != null)
                      CustomTextStyle(
                        text: user.userBio!,
                        textColor: Colors.white70,
                        textAlign: TextAlign.center,
                        maxLine: 2,
                        fontSize: 14,
                      ),
                    if (user.userBio == null)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: context.primary,
                          onTap: () {
                            context.push('/profile_page/edit_profile_page');
                          },
                          child: const Row(
                            mainAxisAlignment: .center,
                            mainAxisSize: .min,
                            children: [
                              Icon(Icons.add, color: Colors.white54, size: 18),
                              CustomTextStyle(
                                text: "Add bio",
                                fontSize: 14,
                                textColor: Colors.white54,
                              ),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: .spaceAround,
                        children: [
                          _buildStatColumn(
                            "Articles",
                            user.totalPosts.toString(),
                          ),
                          _buildStatColumn(
                            "Followers",
                            user.followers.toString(),
                          ),
                          _buildStatColumn(
                            "Following",
                            user.followings.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

Widget _buildStatColumn(String label, String count) {
  return Expanded(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: card,
        onTap: () {},
        child: Column(
          children: [
            CustomTextStyle(
              text: count,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            CustomTextStyle(
              text: label,
              fontSize: 12,
              textColor: Colors.white54,
            ),
          ],
        ),
      ),
    ),
  );
}
