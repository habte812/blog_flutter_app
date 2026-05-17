import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'catche_notifier.g.dart';

@riverpod
class CatcheNotifier extends _$CatcheNotifier {
  @override
  Future<Map<String, String>> build() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _calculateAllSizes();
  }

  Future<Map<String, String>> _calculateAllSizes() async {
    final imageSize = await _getImageCacheSize();
    final hiveSize = await _getHiveBoxesSize();

    return {'images': imageSize, 'database': hiveSize};
  }

  Future<String> _getImageCacheSize() async {
    final directory = await getTemporaryDirectory();
    final cacheDirectory = Directory("${directory.path}/libCachedImageData");
    if (!cacheDirectory.existsSync()) return "0.0 MB";
    int totalSize = 0;
    try {
      cacheDirectory.listSync(recursive: true).forEach((files) {
        if (files is File) totalSize += files.lengthSync();
      });
    } catch (e) {
      return "0.0 MB";
    }
    return "${(totalSize / (1024 * 1024)).toStringAsFixed(1)} MB";
  }

Future<String> _getHiveBoxesSize() async {
  try {
    // 1. Get the actual directory Hive uses
    final docDir = await getApplicationDocumentsDirectory();
    final directory = Directory(docDir.path);
    
    int totalSize = 0;

    // 2. Only measure files related to your boxes
    final boxesToMeasure = [
      'post_cache',
      'recent_search',
      'downloaded_articles',
    ];

    if (directory.existsSync()) {
      final files = directory.listSync();
      for (final file in files) {
        if (file is File) {
          // Check if the filename contains any of our box names
          // This catches 'post_cache.hive', 'post_cache.lock', etc.
          final bool isTargetBox = boxesToMeasure.any((box) => 
            file.path.contains(box));
            
          if (isTargetBox) {
            totalSize += file.lengthSync();
          }
        }
      }
    }

    return "${(totalSize / (1024 * 1024)).toStringAsFixed(2)} MB";
  } catch (e) {
    return "0.0 MB";
  }
}

  Future<void> clearImageCache() async {
    state = const AsyncValue.loading();

    try {
      await DefaultCacheManager().emptyCache();
      final directory = await getTemporaryDirectory();
      final cacheDirectory = Directory("${directory.path}/libCachedImageData");

      if (cacheDirectory.existsSync()) {
        cacheDirectory.listSync().forEach((entity) {
          if (entity is File) {
            try {
              entity.deleteSync();
            } catch (e) {
              debugPrint("Could not delete file: $e");
            }
          }
        });
      }

      await Future.delayed(const Duration(milliseconds: 500));

      state = AsyncValue.data(await _calculateAllSizes());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> clearDatabaseCache() async {
    state = const AsyncValue.loading();
    await Hive.box('post_cache').clear();
    await Hive.box('recent_search').clear();
    await Future.delayed(const Duration(milliseconds: 500));
    state = AsyncValue.data(await _calculateAllSizes());
  }
}
