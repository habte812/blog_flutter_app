import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/viewModel/blog/blog%20detail/blog_detail_notifier.dart';
import 'package:tech_node/data/viewModel/ui/ui%20blog%20data/ui_data_provider.dart';

class CreateAndDraftButton extends ConsumerWidget {
  const CreateAndDraftButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditeMode = ref.watch(uiDataProviderProvider);
    ref.listen(
      isEditeMode.editBlogId != null
          ? updateMyPublishedBlogProvider
          : createBlogProvider,
      (previous, next) {
        next.whenOrNull(
          data: (_) {
            ref.read(uiDataProviderProvider.notifier).resetAll();
            FocusManager.instance.primaryFocus?.unfocus();
            CustomScaffoldMessage.show(
              context,
              message: isEditeMode.editBlogId != null
                  ? 'Blog Updated successfully'
                  : 'Blog created successfully',
            );
            if (isEditeMode.editBlogId != null && !context.mounted) {
              context.pop();
            }
          },
          error: (error, stackTrace) {
            CustomScaffoldMessage.show(
              context,
              message: error.toString(),
              isError: true,
            );

            FocusManager.instance.primaryFocus?.unfocus();
          },
        );
      },
    );
    final createBlogState = ref.watch(createBlogProvider);
    final updateBlogState = ref.watch(updateMyPublishedBlogProvider);
    return Container(
      height: 70,
      color: card,
      padding: const .all(8),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              backgroundColor: Colors.transparent,
              onPressed: () {},
              label: const CustomTextStyle(
                text: 'Save Draft',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: CustomButton(
              onPressed: createBlogState.isLoading || updateBlogState.isLoading
                  ? null
                  : () async {
                      final data = ref
                          .read(uiDataProviderProvider.notifier)
                          .prepareDataForUpload();
                      if (isEditeMode.editBlogId != null) {
                        await ref
                            .read(updateMyPublishedBlogProvider.notifier)
                            .updateBlog(
                              data: data,
                              blogId: isEditeMode.editBlogId!,
                            );
                      } else {
                        await ref
                            .read(createBlogProvider.notifier)
                            .createBlog(data: data);
                      }
                    },
              label: createBlogState.isLoading || updateBlogState.isLoading
                  ? const SizedBox(
                      height: 55,
                      width: 55,
                      child: CustomLoading(color: Colors.white),
                    )
                  : CustomTextStyle(
                      text: isEditeMode.editBlogId != null
                          ? 'Update'
                          : 'Publish',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      textColor:
                          createBlogState.isLoading || updateBlogState.isLoading
                          ? Colors.white54
                          : null,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
