import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_show_dialog.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/blog/blog%20detail/blog_detail_notifier.dart';
import 'package:tech_node/view/create/widgets/category_container.dart';
import 'package:tech_node/view/create/widgets/create_and_draft_button.dart';
import 'package:tech_node/view/create/widgets/create_hashtags.dart';
import 'package:tech_node/view/create/widgets/blog%20content/content_container.dart';
import 'package:tech_node/view/create/widgets/guest/create_guest_page.dart';
import 'package:tech_node/view/create/widgets/reader%20user/if_user_is_reader.dart';
import 'package:tech_node/view/create/widgets/title_container.dart';
import 'package:tech_node/view/create/widgets/thumbnail/upload_thumbnail.dart';
import 'package:tech_node/data/viewModel/ui/ui%20blog%20data/ui_data_provider.dart';

class CreatePage extends HookConsumerWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).status;
    final userRole = ref.watch(userRoleProvider);

    if (authState == AuthStatus.unauthenticated) {
      return const CreateBlogGuestPage();
    } else if (authState == AuthStatus.authenticated ||
        authState == AuthStatus.unverified) {
      if (userRole == 'reader') {
        return const IfUserIsReader();
      }
    } else if (authState == AuthStatus.error) {
      return const CreateBlogGuestPage();
    } else if (authState == AuthStatus.loading) {
      return const CreateBlogGuestPage();
    }

    final theNotifier = ref.read(uiDataProviderProvider.notifier);
    final isEmptyNotifier = useValueNotifier<bool>(true);
    useEffect(() {
      void checkEmpty() {
        final isCurrentlyEmpty =
            theNotifier.blogtitleController.text.trim().isEmpty &&
            theNotifier.blogContentController.document.isEmpty();
        if (isEmptyNotifier.value != isCurrentlyEmpty) {
          isEmptyNotifier.value = isCurrentlyEmpty;
        }
      }

      theNotifier.blogtitleController.addListener(checkEmpty);
      theNotifier.blogContentController.addListener(checkEmpty);
      return () {
        theNotifier.blogtitleController.removeListener(checkEmpty);
        theNotifier.blogContentController.removeListener(checkEmpty);
      };
    }, [theNotifier]);
    return ValueListenableBuilder<bool>(
      valueListenable: isEmptyNotifier,
      builder: (context, isEmpty, child) => PopScope(
        canPop: isEmpty ? true : false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          if (!isEmpty) {
            await customShowDialog(
              context,
              title: "Save as Draft?",
              subTitle: "You can come back and finish your blog post later.",
              onCancel: () {
                FocusManager.instance.primaryFocus?.unfocus();
                ref.read(uiDataProviderProvider.notifier).resetAll();
                context.go('/home');
              },
              onRight: () {
                if (!context.mounted) return;
                context.pop();
              },
              rightButtonText: "Save Draft",
              icon: LucideIcons.save,
              isLoading: () => ref.watch(createBlogProvider).isLoading,
            );
          }
        },
        child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: background,
            elevation: 0,
            centerTitle: true,
            scrolledUnderElevation: 0.5,
            leading: IconButton(
              icon: const Icon(LucideIcons.x, size: 22, color: Colors.white),
              onPressed: () async {
                if (!isEmpty) {
                  await customShowDialog(
                    context,
                    title: "Save as Draft?",
                    subTitle:
                        "You can come back and finish your blog post later.",
                    onCancel: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ref.read(uiDataProviderProvider.notifier).resetAll();
                      context.go('/home');
                    },
                    onRight: () {},
                    rightButtonText: "Save Draft",
                    icon: LucideIcons.save,
                    isLoading: () => ref.watch(createBlogProvider).isLoading,
                  );
                } else if (context.canPop()) {
                  context.pop();
                }
              },
            ),
            actions: [
              Padding(
                padding: const .all(10),
                child: TextButton.icon(
                  icon: const Icon(Icons.undo_outlined, color: Colors.white),
                  style: ButtonStyle(backgroundColor: .all(context.primary)),
                  onPressed: () {
                    ref.read(uiDataProviderProvider.notifier).resetAll();
                  },
                  label: const CustomTextStyle(text: 'Reset', fontSize: 16),
                ),
              ),
            ],
            title: Consumer(
              builder: (context, ref, child) {
                final isEditing = ref.watch(
                  uiDataProviderProvider.select((ed) => ed.editBlogId),
                );
                return CustomTextStyle(
                  text: isEditing != null ? 'Update Post' : 'Create Post',
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                );
              },
            ),
          ),
          body: const CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: UploadThumbnail()),
              SliverToBoxAdapter(child: TitleContainer()),
              SliverToBoxAdapter(child: CategoryContainer()),
              SliverToBoxAdapter(child: ContentContainer()),
              SliverToBoxAdapter(child: CreateHashtags()),
              SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
          bottomNavigationBar: const CreateAndDraftButton(),
        ),
      ),
    );
  }
}
