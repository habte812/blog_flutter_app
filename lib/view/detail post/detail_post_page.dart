import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/notifier%20banner/notifier_banners.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_bottom_sheet.dart';
import 'package:tech_node/core/custom/custom_shimmer_loading.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/viewModel/blog/blog%20detail/blog_detail_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/author%20profile/blog_author_profile.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/comment_sheet_ui.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_content.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_detail_appbar.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_hashtags.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_thumbnail.dart';
import 'package:tech_node/view/detail%20post/widgets/blog_title.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';

class DetailPostPage extends ConsumerWidget {
  final String postId;
  const DetailPostPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blogDetail = ref.watch(blogDetailProvider(postId));
    return PopScope(
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
        body: SafeArea(
          child: RefreshIndicator(
            color: context.primary,
            onRefresh: () async => await ref
                .read(blogDetailProvider(postId).notifier)
                .refreshThePage(postId),
            child: blogDetail.when(
              loading: () => const DetailPostShimmer(),
              error: (error, stackTrace) => Center(
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    TextButton.icon(
                      icon:  Icon(
                        LucideIcons.arrowLeft,
                        color: context.primary,
                      ),
                      onPressed: () {
                        if (!context.mounted) return;
                        context.go('/home');
                      },
                      label:  CustomTextStyle(
                        text: "Go back",
                        fontSize: 15,
                        textColor: context.primary,
                      ),
                    ),
                    if (error.toString() == 'Blog not found')
                      CustomTextStyle(
                        text: error.toString(),
                        textAlign: .center,
                        fontSize: 14,
                        textColor: Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    if (error.toString() != 'Blog not found')
                      CustomErrorNotifier(
                        action: () async => await ref
                            .read(blogDetailProvider(postId).notifier)
                            .refreshThePage(postId),

                        errorMessage: error.toString(),
                      ),
                  ],
                ),
              ),
              data: (data) {
                if (data == null) {
                  return const Center(
                    child: CustomTextStyle(
                      text: "Blog not found",
                      fontSize: 14,
                      textColor: Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: false,
                      snap: true,
                      backgroundColor: background,
                      expandedHeight: 47,
                      collapsedHeight: 45,
                      toolbarHeight: 45,
                      leading: null,
                      surfaceTintColor: background,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.zero,
                        expandedTitleScale: 1.0,
                        title: BlogDetailAppbar(blogDetail: data),
                      ),
                    ),
                    const NotifierBanner(),
                    SliverToBoxAdapter(child: BlogThumbnail(blogDetail: data)),
                    SliverToBoxAdapter(child: BlogTitle(blogDetail: data)),
                    SliverToBoxAdapter(
                      child: BlogAuthorProfile(blogDetail: data),
                    ),
                    SliverToBoxAdapter(child: BlogContent(blogDetail: data)),
                    SliverToBoxAdapter(child: BlogHashtags(blogDetail: data)),
                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButton: blogDetail.when(
          loading: () => Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(color: card, shape: .circle),
          ),
          error: (error, stackTrace) => const SizedBox.shrink(),

          data: (data) {
            if (data == null) {
              return const SizedBox.shrink();
            }
            return Stack(
              children: [
                IconButton(
                  tooltip: 'Comments',
                  color: Colors.white,
                  padding: const .all(10),
                  constraints: const BoxConstraints(),
                  style:  ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(context.primary),
                  ),
                  onPressed: () {
                    CustomBottomSheet.show(
                      context: context,
                      topTitle: CustomTextStyle(
                        text: "${data.commentCount.toString()} Comments",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      child: CommentSheetUi(postId: postId),
                    );
                  },
                  icon: const Icon(LucideIcons.messageSquare, size: 20),
                ),
                Positioned(
                  top: -1,
                  right: 4,
                  child: CustomTextStyle(
                    text: data.commentCount >= 99
                        ? '99+'
                        : data.commentCount.toString(),
                    fontSize: 12,
                    textColor: Colors.white,
                    fontWeight: .bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
