import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/error/blog_exception.dart';
import 'package:tech_node/data/services/image%20services/image_converter_service.dart';

part 'image_processing_service.g.dart';

@riverpod
class ImageProcessingService extends _$ImageProcessingService {
  static const int maxFilesize = 2 * 1024 * 1024;
  @override
  AsyncValue<String?> build() => const AsyncValue.data(null);

  Future<void> pickimageAndCrop({
    required int quality,
    required double ratioX,
    required double ratioY,
    required CropAspectRatioPresetData aspectRatio,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result == null || result.files.single.path == null) return null;
      final file1 = File(result.files.single.path!);
      if (await file1.length() > maxFilesize) {
        throw BlogException('File size exceeds the limit of 2MB');
      }
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file1.path,
        aspectRatio:  CropAspectRatio(ratioX:ratioX , ratioY: ratioY),
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Adjust Profile Picture',
            toolbarColor: background,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: aspectRatio,
            lockAspectRatio: true,
          ),
        ],
      );
      if (croppedFile == null) return null;

      final String outPath = '${croppedFile.path}.webp';
      final File? webpFile = await ref
          .read(imageConverterServiceProvider)
          .convertAndSaveWabp(
            sourcePath: croppedFile.path,
            targetPath: outPath,
            quality: quality,
          );

      return webpFile?.path;
    });
  }
}
