import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/pagination/my%20posted%20blogs/my_posted_blogs_state.dart';
import 'package:tech_node/data/model/pagination/paginated_response_model.dart';
import 'package:tech_node/data/repository/blog/blog_post_repository.dart';
part 'my_posted_blogs_notifier.g.dart';

@riverpod
class MyPostedBlogsNotifier extends _$MyPostedBlogsNotifier {
  @override
  MyPostedBlogsState build() {
    Future.microtask(() => fetchFirstPage());
    return const MyPostedBlogsState();
  }

  Future<void> fetchFirstPage({bool refresh = false}) async {
    if (state.isLoading) return;
    state = state.copyWith(
      status: PaginationStatus.loading,
      clearCursor: true,
      clearError: true,
      myblogs: refresh ? [] : state.myblogs,
    );
    try {
      final repo = await ref
          .read(blogPostRepositoryProvider)
          .getMyPostedBlogs();
      if (!ref.mounted) return;
      state = state.copyWith(
        status: PaginationStatus.success,
        nextCursor: repo.nextCursor,
        hasMorePages: repo.hasMorePages,
        myblogs: repo.data,
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchMorePosts() async {
    if (state.isLoadingMore ||
        !state.hasMorePages ||
        state.nextCursor == null) {
      return;
    }
    state = state.copyWith(status: PaginationStatus.loadingMore);
    try {
      final repo = await ref
          .read(blogPostRepositoryProvider)
          .getMyPostedBlogs(cursor: state.nextCursor);
      if (!ref.mounted) return;
      state = state.copyWith(
        status: PaginationStatus.success,
        nextCursor: repo.nextCursor,
        hasMorePages: repo.hasMorePages,
        myblogs: [...state.myblogs, ...repo.data],
      );
    } catch (e) {
      state = state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refreshThepage() async {
    await fetchFirstPage(refresh: true);
  }
}
