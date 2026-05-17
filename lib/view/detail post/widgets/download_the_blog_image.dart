import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/helper/download_blog_image.dart';
import 'package:tech_node/data/viewModel/download/download_image_progress.dart';

class DownloadTheBlogImage {
  static Future<void> startDownload(
    WidgetRef ref,
    String imageUrl,
    BuildContext context,
  ) async {
    try {
      await DownloadImageService().downloadImage(
        imageUrl,
        (p) => ref.read(downloadProgressNotifier(imageUrl).notifier).state = p,
      );
      ref.read(downloadProgressNotifier(imageUrl).notifier).state = 0.0;
      if (!context.mounted) return;
      CustomScaffoldMessage.show(context, message: "Saved Gallery");
    } catch (e) {
      ref.read(downloadProgressNotifier(imageUrl).notifier).state = 0.0;
      if (!context.mounted) return;
      CustomScaffoldMessage.show(context, message: "Error: $e", isError: true);
    }
  }
}
