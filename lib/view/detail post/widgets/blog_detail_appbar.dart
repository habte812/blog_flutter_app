import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/animation/icon_transition_animation.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/saved%20blogs/save_blog_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_menu.dart';

class BlogDetailAppbar extends ConsumerWidget {
  final BlogsDetailModel blogDetail;
  const BlogDetailAppbar({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      saveBlogProvider(
        blogDetail.previewDatas.id,
        blogDetail.previewDatas.isSaved,
      ),
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
    return Container(
      color: background,
      child: Row(
        children: [
          IconButton(
            highlightColor: background,
            splashColor: background,
            onPressed: () {
              if (!context.mounted) return;
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          ),
          Expanded(
            child: CustomTextStyle(
              text: blogDetail.previewDatas.title,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              maxLine: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          BlogMenu(blogDetail: blogDetail),
          Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authProvider).status;
              final isSaved = ref.watch(
                saveBlogProvider(
                  blogDetail.previewDatas.id,
                  blogDetail.previewDatas.isSaved,
                ),
              );
              return IconTransitionAnimation(
                isSaved: isSaved,
                onTap: () {
                  if (authState != AuthStatus.authenticated) {
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
                          blogDetail.previewDatas.id,
                          blogDetail.previewDatas.isSaved,
                        ).notifier,
                      )
                      .saveTheBlog();
                },
                iconSize: 28,
              );
            },
          ),
        ],
      ),
    );
  }
}
