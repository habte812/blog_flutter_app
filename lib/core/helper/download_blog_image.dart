import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tech_node/core/error/dio_exception_handler.dart';

class DownloadImageService {
  final Dio _dio = Dio();
  Future<void> downloadImage(String url, Function(double) onProgress) async {
    try {
      final status = await Permission.storage.request();
      if (status.isDenied) throw 'Permission doesn\'t guranted';
      final tempDir = await getTemporaryDirectory();
      final String fileName = url.split('/').last;
      final String imagePath = '${tempDir.path}/$fileName';

      await _dio.download(
        url,
        imagePath,
        onReceiveProgress: (count, total) {
          if (total != -1) {
            onProgress(count / total);
          }
        },
      );
      await Gal.putImage(imagePath);
      final theFile = File(imagePath);
      if (await theFile.exists()) await theFile.delete();
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
}
