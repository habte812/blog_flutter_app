import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/error/blog_exception.dart';

part 'image_converter_service.g.dart';

abstract class ImageConverterService {
  Future<File?> convertAndSaveWabp({
    required String sourcePath,
    required String targetPath,
    required int quality,
  });
}

@riverpod
ImageConverterService imageConverterService(Ref ref) => ImageConverter();

class ImageConverter implements ImageConverterService {
  @override
  Future<File?> convertAndSaveWabp({
    required String sourcePath,
    required String targetPath,
    required int quality,
  }) async {
    try {
      final XFile? result = await FlutterImageCompress.compressAndGetFile(
        sourcePath,
        targetPath,
        format: CompressFormat.webp,
        quality: quality,
      );

      return result != null ? File(result.path) : null;
    } catch ($e) {
      throw BlogException('Unable to convert, try again');
    }
  }
}
