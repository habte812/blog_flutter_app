import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/pagination/paginated_response_model.dart';
import 'package:tech_node/data/model/pagination/saved%20blogs/saved_blogs_state.dart';
import 'package:tech_node/data/repository/save%20blog/save_blog_repository.dart';

part 'save_blog_notifier.g.dart';

@riverpod
class SaveBlogNotifier extends _$SaveBlogNotifier {
  @override
  bool build(int blogId, bool intialstate) {
    return intialstate;
  }

  Future<void> saveTheBlog() async {
    final previousState = state;
    state = !previousState;

    try {
      final repo = ref.read(saveBlogRepositoryProvider);
      final serviceState = await repo.saveTheBlog(blogId: blogId);
      if (!ref.mounted) return;

      state = serviceState;
    } catch (e) {
      if (!ref.mounted) return;
      state = previousState;
      rethrow;
    }
  }
}

@riverpod
class MySavedBlogsNotifier extends _$MySavedBlogsNotifier {
  @override
  SavedBlogsState build() {
    Future.microtask(() => firstFetchSaved());
    return const SavedBlogsState();
  }

  Future<void> firstFetchSaved({bool refresh = false}) async {
    if (state.isLoading) return;
    state = state.copyWith(
      status: PaginationStatus.loading,
      clearError: true,
      clearCursor: true,
      savedblogs: refresh ? [] : state.savedblogs,
    );
    try {
      final repo = ref.read(saveBlogRepositoryProvider);
      final blogs = await repo.getMySavedBlogs();
      if (!ref.mounted) return;
      state = state.copyWith(
        savedblogs: blogs.data,
        nextCursor: blogs.nextCursor,
        hasMorePages: blogs.hasMorePages,
        status: PaginationStatus.success,
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchMoreSaveds() async {
    if (state.isLoadingMore ||
        !state.hasMorePages ||
        state.nextCursor == null) {
      return;
    }
    state = state.copyWith(status: PaginationStatus.loadingMore);

    try {
      final repo = ref.read(saveBlogRepositoryProvider);
      final blogs = await repo.getMySavedBlogs(cursor: state.nextCursor);
      if (!ref.mounted) return;
      state = state.copyWith(
        savedblogs: [...state.savedblogs, ...blogs.data],
        nextCursor: blogs.nextCursor,
        hasMorePages: blogs.hasMorePages,
        status: PaginationStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refreshThepage() async {
    await firstFetchSaved(refresh: true);
  }
}
