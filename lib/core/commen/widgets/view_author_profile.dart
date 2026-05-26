import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/widgets/follow_unfollow_author_profile.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/viewModel/blog/blog%20detail/blog_detail_notifier.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';
import 'package:tech_node/core/commen/widgets/share%20profile/share_profile.dart';

class ViewAuthorProfile extends ConsumerWidget {
  final String authorID;
  const ViewAuthorProfile({super.key, required this.authorID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theAuthor = ref.watch(seeAuthorProfileProvider(authorID));
    return RefreshIndicator(
      color: context.primary,
      onRefresh: () async {
        await ref
            .read(seeAuthorProfileProvider(authorID).notifier)
            .refreshProfile(authorID);
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/home');
          }
        },
        child: Scaffold(
          backgroundColor: background,
          body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 260.0,
                    pinned: true,
                    stretch: true,
                    backgroundColor: background,
                    surfaceTintColor: background,
                    leading: IconButton(
                      highlightColor: context.primary,
                      splashColor: context.primary,
                      onPressed: () {
                        if (!context.mounted) return;
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/home');
                        }
                      },
                      icon: const Icon(
                        LucideIcons.arrowLeft,
                        color: Colors.white,
                      ),
                    ),
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
                          ProfileBioAndTotal(authorID: authorID),
                        ],
                      ),
                    ),
                    actions: [
                      theAuthor.when(
                        data: (data) {
                          if (!data.isOwner) {
                            return FollowUnfollowAuthorProfile(
                              fromDetail: false,
                              authorName: data.userName,
                              authorId: data.id.toString(),
                              initialState: data.isFollowing,
                            );
                          }
                          return IconButton(
                            onPressed: () {
                              if (!context.mounted) return;
                              ShareProfile.shareAuthorProfile(
                                data.id.toString(),
                                data.userName,
                              );
                            },
                            icon: const Icon(
                              Icons.ios_share_rounded,
                              color: Colors.white,
                            ),
                          );
                        },
                        error: (error, stackTrace) => const SizedBox.shrink(),
                        loading: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ];
              },
              body: const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileBioAndTotal extends ConsumerWidget {
  final String authorID;
  const ProfileBioAndTotal({super.key, required this.authorID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authorProfile = ref.watch(seeAuthorProfileProvider(authorID));
    return SafeArea(
      child: authorProfile.when(
        loading: () => const CustomUserProfileShimmer(),
        error: (error, stackTrace) => CustomErrorNotifier(
          action: () => ref
              .read(seeAuthorProfileProvider(authorID).notifier)
              .refreshProfile(authorID),
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
                            errorWidget: (context, url, error) => const Center(
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
                Row(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    CustomTextStyle(
                      text: user.userName,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 3),
                    if (user.userRole == 'admin' || user.userRole == 'author')
                      const Icon(
                        Icons.verified_sharp,
                        color: Colors.white,
                        size: 20,
                      ),
                  ],
                ),
                if (user.userBio != null)
                  CustomTextStyle(
                    text: user.userBio!,
                    textColor: Colors.white70,
                    textAlign: .center,
                    fontSize: 14,
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: .spaceAround,
                    children: [
                      _buildStatColumn("Articles", user.totalPosts.toString()),
                      _buildStatColumn("Followers", user.followers.toString()),
                      _buildStatColumn("Following", user.followings.toString()),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildStatColumn(String label, String count) {
  return Expanded(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
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
