import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AnimatedImage extends StatelessWidget {
  final String? thumbnailPath;
  final int? isEditingMode;
  final String? editThumbnailUrl;
  const AnimatedImage({
    super.key,
    this.thumbnailPath,
    this.isEditingMode,
    this.editThumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation =
              Tween<Offset>(
                begin: const Offset(0.0, -1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.bounceInOut),
              );
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: offsetAnimation, child: child),
          );
        },
        child: thumbnailPath != null
            ? ClipRRect(
                key: ValueKey(thumbnailPath),
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(thumbnailPath!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : isEditingMode != null && editThumbnailUrl != null
            ? ClipRRect(
                key: ValueKey(editThumbnailUrl),
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  editThumbnailUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            // 3. Fallback: No local file and no edit URL (Create mode)
            : const SizedBox(
                key: ValueKey('placeholder'),
                child: Icon(LucideIcons.image, size: 70, color: Colors.white54),
              ),
      ),
    );
  }
}
