import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CreateHashtags extends HookWidget {
  const CreateHashtags({super.key});

  @override
  Widget build(BuildContext context) {
    final hashtags = useState<List<String>>([]);
    final hashController = useTextEditingController();
    void addHashtags(String value) {
      String cleanTag = value.trim().replaceAll(RegExp(r'[^\w]'), '');
      if (cleanTag.length > 16) {
        cleanTag = cleanTag.substring(0, 16);
      }
      if (cleanTag.isNotEmpty && !hashtags.value.contains(cleanTag)) {
        hashtags.value = [...hashtags.value, cleanTag];
        hashController.clear();
      } else {
        hashController.clear();
      }
    }

    return Padding(
      padding: .only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          CustomTextStyle(
            text: 'Hashtags',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 10),
          TextField(
            controller: hashController,
            readOnly: hashtags.value.length == 6,
            decoration: InputDecoration(
              hintText: hashtags.value.length >= 6
                  ? 'Maximum 6 tags reached'
                  : "Type tag (16 char only) and press space or enter...",
              prefixText: hashtags.value.length >= 6 ? '' : "#",
              hintStyle: TextStyle(
                color: hashtags.value.length >= 6
                    ? Colors.redAccent
                    : Colors.white70,
                fontSize: 14,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              counterText: "",
            ),
            onSubmitted: addHashtags,

            onChanged: (value) {
              if (value.endsWith(' ') && hashtags.value.length < 6) {
                addHashtags(value);
              } else if (hashtags.value.length >= 6) {
                hashController.clear();
              }
            },
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: hashtags.value.map((tag) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => hashtags.value = hashtags.value
                    .where((t) => t != tag)
                    .toList(),
                child: Container(
                  padding: const .symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    borderRadius: .circular(12),
                  ),
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      CustomTextStyle(
                        text: '#$tag',
                        fontSize: 15,
                        textColor: primary,
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.close,
                        size: 14,
                        color: primary.withValues(alpha: 0.6),
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
