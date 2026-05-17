import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/blog/follow%20author/follow_notifier.dart';
import 'package:tech_node/core/commen/widgets/share%20profile/share_profile.dart';

class FollowUnfollowAuthorProfile extends ConsumerWidget {
  final String authorId;
  final String authorName;
  final bool initialState;
  final bool fromDetail;
  const FollowUnfollowAuthorProfile({
    super.key,
    required this.authorId,
    required this.initialState,
    required this.authorName,
    required this.fromDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(followProvider(authorId, initialState), (previous, next) {
      if (previous == null) return;
      if (next == true && previous == false) {
        CustomScaffoldMessage.show(context, message: 'Following successfully');
      }

      if (next == false && previous == true) {
        CustomScaffoldMessage.show(context, message: 'Unfollowed');
      }
    });
    return SafeArea(
      child: Padding(
        padding: const .only(right: 10.0),
        child: Row(
          children: [
            if (!fromDetail)
              IconButton(
                onPressed: () {
                  if (!context.mounted) return;
                  ShareProfile.shareAuthorProfile(authorId, authorName);
                },
                icon: const Icon(Icons.ios_share_rounded, color: Colors.white),
              ),
            Consumer(
              builder: (context, ref, child) {
                final authStatus = ref.watch(authProvider).status;
                final isFollowing = ref.watch(
                  followProvider(authorId, initialState),
                );
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: fromDetail ? background : context.primary,
                    onTap: authStatus == AuthStatus.unauthenticated
                        ? () {
                            CustomScaffoldMessage.show(
                              context,
                              message: "Login to continue",
                              isError: true,
                            );
                          }
                        : () => ref
                              .read(
                                followProvider(authorId, initialState).notifier,
                              )
                              .toggle(),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Icon(
                          fromDetail
                              ? isFollowing
                                    ? Icons.check
                                    : Icons.add
                              : isFollowing
                              ? Icons.person_remove_alt_1_outlined
                              : Icons.add,
                          color: fromDetail ? context.primary : Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        CustomTextStyle(
                          text: fromDetail
                              ? isFollowing
                                    ? 'Following'
                                    : 'Follow'
                              : isFollowing
                              ? "Unfollow"
                              : "Follow",
                          fontSize: 14,
                          textColor: fromDetail
                              ? context.primary
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
