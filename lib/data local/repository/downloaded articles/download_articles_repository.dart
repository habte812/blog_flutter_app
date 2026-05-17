import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data%20local/local%20Models/offline_blogs_model.dart';

part 'download_articles_repository.g.dart';

abstract class DownloadArticlesRepository {
  Future<void> downloadBlog(OfflineBlogsModel blog);
  List<OfflineBlogsModel> getOfflineBlogs();
  Future<String> deleteTheBlog(int id);
}

@riverpod
DownloadArticlesRepository downloadArticlesRepository(Ref ref) {
  return DownloadArticlesRepositoryImp();
}

class DownloadArticlesRepositoryImp implements DownloadArticlesRepository {
  final Dio _dio = Dio();
  final box = Hive.box<OfflineBlogsModel>('downloaded_articles');
  @override
  Future<void> downloadBlog(OfflineBlogsModel blog) async {
    if (box.containsKey(blog.id)) throw "Already Downloaded";
    String? localPath;
    String? localauthoImage;
    if (blog.thumbnail != null && blog.thumbnail!.isNotEmpty) {
      localPath = await _downloadImage(
        blog.thumbnail!,
        "${blog.id}_${DateTime.now().millisecond}",
        false,
      );
    }
    if (blog.authorImage != null && blog.authorImage!.isNotEmpty) {
      localauthoImage = await _downloadImage(
        blog.authorImage!,
        "${blog.authorID}_${DateTime.now().millisecond}",
        true,
      );
    }
    final theBlogToSave = blog.copyWith(
      thumbnail: localPath ?? blog.thumbnail,
      authorImage: localauthoImage ?? blog.authorImage,
    );
    await box.put(blog.id, theBlogToSave);
  }

  @override
  List<OfflineBlogsModel> getOfflineBlogs() {
    return box.values.toList().reversed.toList();
  }

  @override
  Future<String> deleteTheBlog(int id) async {
    try {
      await box.delete(id);
      return "Blog deleted successfully";
    } catch (e) {
      return "Unable to delete";
    }
  }

  Future<String?> _downloadImage(
    String url,
    String fileName,
    bool isAuthorImage,
  ) async {
    try {
      final direct = await getApplicationDocumentsDirectory();
      final savePath = isAuthorImage
          ? '${direct.path}/offline_images/author/$fileName'
          : '${direct.path}/offline_images/thumbnail/$fileName';
      await _dio.download(url, savePath);
      return savePath;
    } catch (e) {
      throw "Unable to download";
    }
  }


}
