import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data%20local/local%20Models/offline_blogs_model.dart';
import 'package:tech_node/data%20local/repository/downloaded%20articles/download_articles_repository.dart';

part 'download_article_notifier.g.dart';

@riverpod
class DownloadArticleNotifier extends _$DownloadArticleNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> startDownload(OfflineBlogsModel blog) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repo = ref.read(downloadArticlesRepositoryProvider);

      await repo.downloadBlog(blog);
    });
  }
}

@riverpod
class GetListsOfDownloaded extends _$GetListsOfDownloaded {
  @override
  FutureOr<List<OfflineBlogsModel>> build() {
    final repo = ref.read(downloadArticlesRepositoryProvider);
    return repo.getOfflineBlogs();
  }

  Future<void> refreshTheCategory() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(downloadArticlesRepositoryProvider).getOfflineBlogs();
    });
  }
}

@riverpod
class DeleteTheOfflineBlog extends _$DeleteTheOfflineBlog {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> deleteBlog(int id) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final repo = ref.read(downloadArticlesRepositoryProvider);
      await repo.deleteTheBlog(id);
    });
    if (!ref.mounted) return;
    state = result;
  }
}
