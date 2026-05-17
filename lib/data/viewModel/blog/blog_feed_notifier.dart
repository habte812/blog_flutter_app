import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/pagination/posted%20blogs/posted_blogs_state.dart';
import 'package:tech_node/data/model/pagination/saved%20blogs/saved_blogs_state.dart';
import 'package:tech_node/data/repository/blog/blog_post_repository.dart';
part 'blog_feed_notifier.g.dart';

@riverpod
class BlogFeedNotifier extends _$BlogFeedNotifier {
  @override
  PostedBlogsState build() {
    Future.microtask(() => fetchFirstPage());
    return PostedBlogsState();
  }

  Future<void> fetchFirstPage({bool refresh = false}) async {
    if (state.isLoading) return;
    state = state.copyWith(
      status: PaginationStatus.loading,
      clearCursor: true,
      clearError: true,
      items: refresh ? [] : state.items,
    );
    try {
      final repo = await ref.read(blogPostRepositoryProvider).fetchBlogIndex();
      if (!ref.mounted) return;
      state = state.copyWith(
        status: PaginationStatus.success,
        nextCursor: repo.nextCursor,
        hasMorePages: repo.hasMorePages,
        items: repo.data,
        layout: repo.layout
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
    try{
      final repo = await ref.read(blogPostRepositoryProvider).fetchBlogIndex(cursor: state.nextCursor);
      if (!ref.mounted) return;
       state = state.copyWith(
        status: PaginationStatus.success,
        nextCursor: repo.nextCursor,
        hasMorePages: repo.hasMorePages,
        items: [...state.items,...repo.data],
        layout: [...state.layout,...repo.layout]
      );
    }catch(e){
      state = state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: e.toString(),
      );}
  }

 Future<void> refreshThepage() async {
    await fetchFirstPage(refresh: true);
  }
}

