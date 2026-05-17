import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data%20local/repository/settings/catche_notifier.dart';
import 'package:tech_node/view/settings/setting_page.dart';

class CacheWidget extends ConsumerWidget {
  const CacheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catcheData = ref.watch(catcheProvider);
    return Padding(
      padding: const .symmetric(horizontal: 10),
      child: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              return catcheData.when(
                loading: () => const Padding(
                  padding: .symmetric(vertical: 15, horizontal: 5),
                  child: Center(child: CustomLoading()),
                ),
                error: (e, _) => CustomTextStyle(
                  text: 'Error calculating cache: $e',
                  fontSize: 14,
                ),
                data: (sizes) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(title: "Storage Management"),
                      CacheTile(
                        title: "Images & Thumbnails",
                        subtitle: "Cached images for faster loading",
                        size: sizes['images']!,
                        onClear: () async {
                          await ref
                              .read(catcheProvider.notifier)
                              .clearImageCache();
                        },
                      ),

                      CacheTile(
                        title: "Database Cache",
                        subtitle: "Posts, search history, and temporary data",
                        size: sizes['database']!,
                        onClear: () async {
                          await ref
                              .read(catcheProvider.notifier)
                              .clearDatabaseCache();
                        },
                      ),

                      // CacheTile(
                      //   title: "Recent Searches",
                      //   subtitle: "Your past search keywords",
                      //   size: "0.8 MB",
                      //   onClear: () {
                      //   },
                      // ),

                      // Center(
                      //   child: TextButton.icon(
                      //     onPressed: () {},
                      //     icon: const Icon(
                      //       Icons.delete_sweep,
                      //       color: Colors.redAccent,
                      //     ),
                      //     label: const CustomTextStyle(
                      //       text: "Clear All App Cache",
                      //       textColor: Colors.redAccent,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 14,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 2),
                    ],
                  );
                },
              );
            },
          ),
          const Divider(color: Colors.white10, height: 40),
          const CustomTextStyle(
            text:
                "Note: Clearing cache will not delete your account or saved settings.",
            fontSize: 12,
            textColor: Colors.white24,
            textAlign: .center,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class CacheTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String size;
  final VoidCallback onClear;

  const CacheTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.size,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: .zero,
      title: CustomTextStyle(
        text: title,
        textColor: Colors.white,
        fontSize: 15,
        fontWeight: .w600,
      ),
      subtitle: CustomTextStyle(
        text: "$subtitle ~ $size",
        textColor: Colors.white38,
        fontSize: 12,
        maxLine: 2,
        overflow: .ellipsis,
        fontWeight: .normal,
      ),
      trailing: TextButton(
        onPressed: onClear,
        child: const CustomTextStyle(
          text: "Clear",
          textColor: Colors.blueAccent,
          fontSize: 14,
        ),
      ),
    );
  }
}
