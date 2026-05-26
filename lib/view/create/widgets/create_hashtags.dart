import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/viewModel/ui/ui%20blog%20data/ui_data_provider.dart';

class CreateHashtags extends ConsumerWidget {
  const CreateHashtags({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hashNotifier = ref.read(uiDataProviderProvider.notifier);
    final hashtags = ref.watch(
      uiDataProviderProvider.select((tag) => tag.listOfHashtags),
    );
    final hashController = hashNotifier.hastagsController;
    void addHashtags(String value) {
      String cleanTag = value.trim().replaceAll(RegExp(r'[^\w]'), '');
      if (cleanTag.length > 16) cleanTag = cleanTag.substring(0, 16);
      if (cleanTag.isNotEmpty) {
        hashNotifier.addBlogHashtags(cleanTag);
        hashController.clear();
      }
    }

    return Padding(
      padding: const .only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const CustomTextStyle(
            text: 'Hashtags',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: hashController,
            readOnly: hashtags.length == 6,
            decoration: InputDecoration(
              hintText: hashtags.length >= 6
                  ? 'Maximum 6 tags reached'
                  : "Type tag (16 char only) and press space or enter...",
              prefixText: hashtags.length >= 6 ? '' : "#",
              hintStyle: TextStyle(
                color: hashtags.length >= 6 ? Colors.redAccent : Colors.white70,
                fontSize: 14,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              counterText: "",
            ),
            onSubmitted: addHashtags,

            onChanged: (value) {
              if (value.endsWith(' ') && hashtags.length < 6) {
                addHashtags(value);
              } else if (hashtags.length >= 6) {
                hashController.clear();
              }
            },
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: hashtags.map((tag) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => hashNotifier.removeBlogHashtags(tag),
                child: Container(
                  padding: const .symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.primary.withValues(alpha: 0.1),
                    borderRadius: .circular(12),
                  ),
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      CustomTextStyle(
                        text: '#$tag',
                        fontSize: 15,
                        textColor: context.primary,
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.close,
                        size: 14,
                        color: context.primary.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
