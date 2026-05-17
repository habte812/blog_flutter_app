import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/services/image%20services/image_processing_service.dart';
import 'package:tech_node/data/viewModel/ui/ui%20blog%20data/ui_data_provider.dart';
import 'package:tech_node/view/create/widgets/thumbnail/animated_image.dart';

class UploadThumbnail extends ConsumerWidget {
  const UploadThumbnail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnailPath = ref.watch(
      uiDataProviderProvider.select((s) => s.blogThumbnailPath),
    );
    final isEditingMode = ref.watch(
      uiDataProviderProvider.select((s) => s.editBlogId),
    );
    final editThumbnailUrl = ref.watch(
      uiDataProviderProvider.select((s) => s.editThumbnailUrl),
    );
    final imageProcesser = ref.watch(imageProcessingServiceProvider);
    final isProcessing = imageProcesser.isLoading;
    final hasError = imageProcesser.hasError;
    final String theError = imageProcesser.error.toString();
    return Container(
      margin: const .all(16),
      padding: const .all(10),
      decoration: BoxDecoration(
        color: card,
        borderRadius: .circular(10),
        border: .all(color: Colors.white24),
      ),
      child: Column(
        children: [
          AnimatedImage(
            thumbnailPath: thumbnailPath,
            isEditingMode: isEditingMode,
            editThumbnailUrl: editThumbnailUrl,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    const CustomTextStyle(
                      text: "Thumbnail",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),

                    CustomTextStyle(
                      text: isProcessing
                          ? 'Loading...'
                          : hasError
                          ? theError
                          : thumbnailPath != null
                          ? thumbnailPath.split('/cache/').last
                          : "JPG, PNG, Webp up to 2MB",
                      fontSize: 13,
                      textColor: hasError ? Colors.red : Colors.white54,
                      maxLine: 1,
                      overflow: .ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: CustomButton(
                  width: 100,
                  height: 40,
                  onPressed: isProcessing
                      ? null
                      : () {
                          ref
                              .read(uiDataProviderProvider.notifier)
                              .pickAndProcessBlogThumbnail();
                        },
                  label: CustomTextStyle(
                    text: (thumbnailPath != null || isEditingMode != null)
                        ? 'Change'
                        : 'Upload',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
