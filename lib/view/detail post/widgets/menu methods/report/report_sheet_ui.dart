import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_field.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';
import 'package:tech_node/data/model/report%20blog/report_blog_model.dart';
import 'package:tech_node/data/viewModel/blog/report%20blog/report_blog_notifier.dart';

class ReportSheetUi extends HookConsumerWidget {
  final BlogsDetailModel blogDetail;
  const ReportSheetUi({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsController = useTextEditingController();
    final selectedReason = useState<String?>(null);
    final activeCategory = useState<String?>(null);
    final reportCategories = useState<List<Map<String, dynamic>>>([
      {
        'icon': LucideIcons.shieldAlert,
        'label': 'Inappropriate Content',
        'subReasons': [
          'Hate Speech',
          'Harassment',
          'Violent Content',
          'Nudity',
        ],
      },
      {
        'icon': LucideIcons.copy,
        'label': 'Intellectual Property',
        'subReasons': ['Plagiarism', 'Copyright Infringement'],
      },
      {
        'icon': LucideIcons.info,
        'label': 'Quality Issues',
        'subReasons': ['Spam', 'Misleading Info', 'Broken Media'],
      },
      {
        'icon': LucideIcons.moreHorizontal,
        'label': 'Other',
        'subReasons': null,
      },
    ]);

    final currentSubReasons = activeCategory.value != null
        ? reportCategories.value.firstWhere(
                (element) => element['label'] == activeCategory.value,
              )['subReasons']
              as List<String>?
        : null;
    ref.listen(reportBlogProvider, (previous, next) {
      next.when(
        data: (value) {
          if (value == 'Reported') {
            if (context.mounted) {
              CustomScaffoldMessage.show(
                context,
                message: 'Report submitted successfully.',
              );
              context.pop();
            }
          } else {
            if (context.mounted) {
              CustomScaffoldMessage.show(context, message: value.toString());
            }
          }
        },
        error: (error, stackTrace) {
          CustomScaffoldMessage.show(context, message: error.toString());
        },
        loading: () {},
      );
    });
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      if (currentSubReasons != null)
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            activeCategory.value = null;
                            selectedReason.value = null;
                          },
                        ),

                      CustomTextStyle(
                        text: activeCategory.value ?? "Report Blog",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomTextStyle(
                        text: "Select a reason for reporting this content.",
                        fontSize: 13,
                        textColor: Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: currentSubReasons != null
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: currentSubReasons.map((sub) {
                            final isSelected = selectedReason.value == sub;
                            return ListTile(
                              selected: isSelected,
                              selectedTileColor: Colors.redAccent.withValues(
                                alpha: 0.1,
                              ),
                              title: CustomTextStyle(
                                text: sub,
                                fontSize: 15,
                                textColor: isSelected
                                    ? Colors.redAccent
                                    : Colors.white,
                              ),
                              trailing: isSelected
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.redAccent,
                                    )
                                  : null,
                              onTap: () => selectedReason.value = sub,
                            );
                          }).toList(),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: reportCategories.value.map((category) {
                            return ListTile(
                              leading: Icon(
                                category['icon'],
                                color: Colors.redAccent,
                                size: 22,
                              ),
                              title: CustomTextStyle(
                                text: category['label'],
                                fontSize: 16,
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.white24,
                              ),
                              onTap: () {
                                if (category['subReasons'] != null) {
                                  activeCategory.value = category['label'];
                                } else {
                                  selectedReason.value = category['label'];
                                }
                              },
                            );
                          }).toList(),
                        ),
                ),
              ),

              if (selectedReason.value != null) ...[
                const SizedBox(height: 20),
                CustomTextField(
                  controller: detailsController,
                  hintText: "Tell us more (optional)...",
                  hintStyle: const TextStyle(color: Colors.white30),
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    final reportState = ref.watch(reportBlogProvider);
                    return CustomButton(
                      backgroundColor: reportState.isLoading
                          ? Colors.transparent
                          : null,
                      width: double.infinity,
                      height: 50,
                      onPressed: reportState.isLoading
                          ? () {}
                          : () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final finalReport = ReportBlogModel(
                                blogId: blogDetail.previewDatas.id,
                                reason: selectedReason.value!,
                                detail: detailsController.text,
                              );
                              ref
                                  .read(reportBlogProvider.notifier)
                                  .reportBlog(data: finalReport);
                            },
                      label: reportState.isLoading
                          ? const SizedBox(
                              height: 50,
                              width: 50,
                              child: CustomLoading(color: Colors.white),
                            )
                          : const CustomTextStyle(
                              text: "Submit Report",
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                    );
                  },
                ),
              ],
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
