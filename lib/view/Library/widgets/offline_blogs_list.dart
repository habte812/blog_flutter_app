import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/commen/local_bLogs_list_card.dart';
import 'package:tech_node/core/custom/custom_empty_state.dart';
import 'package:tech_node/core/custom/custom_error_notifier.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_show_dialog.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data%20local/viewModel/download%20Article/download_article_notifier.dart';

class OfflineBlogsList extends StatelessWidget {
  const OfflineBlogsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final offlineBlogs = ref.watch(getListsOfDownloadedProvider);
        return offlineBlogs.when(
          loading: () => const CustomLoading(),
          error: (error, stackTrace) => CustomErrorNotifier(
            action: () {},
            errorMessage: error.toString(),
          ),

          data: (data) {
            if (data.isEmpty) {
              return Padding(
                padding: .only(top: MediaQuery.of(context).size.height * 0.12),
                child: const CustomEmptyState(
                  description:
                      "Download articles to read them offline, even without an internet connection.",
                  title: "No Downloads Yet",
                  icon: Icons.download_done_rounded,
                ),
              );
            }
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return LocalBLogsListPage(
                      theModel: data[index],
                      isSaved: false,
                    );
                  },
                ),

                const SizedBox(height: 5),
                TextButton.icon(
                  icon: const Icon(LucideIcons.trash2, color: Colors.red),
                  onPressed: () {
                    if (!context.mounted) return;
                    customShowDialog(
                      context,
                      title: "Remove All",
                      subTitle: "Are you sure you want to remove all blogs?",
                      onCancel: () {},
                      onRight: () {},
                      rightButtonText: "Remove",
                      icon: LucideIcons.trash,
                      iconColor: Colors.red,
                      cancelButtonText: "Cancel",
                      isLoading: () =>
                          ref.watch(deleteTheOfflineBlogProvider).isLoading,
                    );
                  },
                  label: const CustomTextStyle(
                    text: "Remove All",
                    fontSize: 15,
                    fontWeight: .bold,
                    textColor: Colors.red,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}
