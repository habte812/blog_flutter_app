import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/animation/icon_transition_animation.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/model/blog/blogs_preview_model.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/saved%20blogs/save_blog_notifier.dart';

class CommonAuthorProfile extends ConsumerWidget {
  final double radius;
  final BlogsPreviewModel blogModel;
  const CommonAuthorProfile({
    super.key,
    required this.radius,
    required this.blogModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      saveBlogProvider(blogModel.id, blogModel.isSaved),
      (previous, next) {
        if (previous == null) return;
        if (next == true && previous == false) {
          CustomScaffoldMessage.show(
            context,
            message: 'Blog saved successfully',
          );
        }

        if (next == false && previous == true) {
          CustomScaffoldMessage.show(
            context,
            message: 'Blog removed from bookmarks',
          );
        }
      },
      onError: (error, stack) {
        CustomScaffoldMessage.show(
          context,
          message: 'Failed to update bookmark. Please try again.',
          isError: true,
        );
      },
    );
    return Row(
      mainAxisSize: .min,
      children: [
        Expanded(
          flex: 10,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: card,
              highlightColor: card,
              onTap: () {
                context.push('/author-profile/${blogModel.author.id}/');
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: .circular(radius),
                    child: CircleAvatar(
                      radius: radius,
                      backgroundColor: card,
                      child: blogModel.author.profilePicture == null
                          ? Icon(
                              LucideIcons.user,
                              color: Colors.white54,
                              size: radius,
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: blogModel.author.profilePicture!,
                              placeholder: (context, url) => Center(
                                child: Icon(
                                  LucideIcons.user,
                                  color: Colors.white54,
                                  size: radius,
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(
                                  LucideIcons.user,
                                  color: Colors.redAccent,
                                  size: radius,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          mainAxisSize: .min,
                          children: [
                            Flexible(
                              child: CustomTextStyle(
                                text: blogModel.author.name,
                                overflow: .ellipsis,
                                textColor: Colors.white54,
                                maxLine: 1,
                                fontSize: 14,
                              ),
                            ),
                            if (blogModel.author.userRole == 'admin' ||
                                blogModel.author.userRole == 'author') ...[
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.verified_sharp,
                                color: Color(0xff137fec),
                                size: 14,
                              ),
                            ],
                          ],
                        ),
                        CustomTextStyle(
                          text: blogModel.publishedAt,
                          overflow: .visible,
                          textColor: Colors.white54,
                          maxLine: 1,
                          fontSize: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        const Icon(LucideIcons.eye, color: Colors.white54, size: 20),
        const SizedBox(width: 4),
        CustomTextStyle(text: blogModel.viewCount.toString(), fontSize: 12),
        Consumer(
          builder: (context, ref, child) {
            final authState = ref.watch(authProvider).status;
            final isSaved = ref.watch(
              saveBlogProvider(blogModel.id, blogModel.isSaved),
            );

            return IconTransitionAnimation(
              iconSize: 23,
              isSaved: isSaved,
              onTap: () {
                if (authState == AuthStatus.unauthenticated) {
                  CustomScaffoldMessage.show(
                    context,
                    message: "Please login to save blogs",
                    isError: true,
                  );
                  return;
                }
                ref
                    .read(
                      saveBlogProvider(
                        blogModel.id,
                        blogModel.isSaved,
                      ).notifier,
                    )
                    .saveTheBlog();
              },
            );
          },
        ),
      ],
    );
  }
}
