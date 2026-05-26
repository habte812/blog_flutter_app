import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/author/author_model.dart';
import 'package:tech_node/data/model/pagination/following%20blogs/following_blogs_state.dart';
import 'package:tech_node/data/model/pagination/paginated_response_model.dart';
import 'package:tech_node/data/repository/following/following_repository.dart';

part 'follow_notifier.g.dart';

@Riverpod(keepAlive: true)
class FollowNotifier extends _$FollowNotifier {
  @override
  bool build(String authorID, bool intialstate) {
    return intialstate;
  }

  Future<void> toggle() async {
    final previousState = state;
    state = !previousState;
    try {
      final repo = ref.read(followingRepositoryProvider);
      final serverStatus = await repo.followAuthor(authorID: authorID);
      state = serverStatus;
    } catch (e) {
      state = previousState;
    }
  }

  Future<void> refreshThePage() async {
    state = intialstate;
  }
}

@riverpod
class GetFollowingsNotifier extends _$GetFollowingsNotifier {
  @override
  FutureOr<List<AuthorModel>> build() async {
    final repo = ref.read(followingRepositoryProvider);
    final followings = await repo.getMyFollowings();
    return followings;
  }

  Future<void> refreshThePage() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async => await ref.read(followingRepositoryProvider).getMyFollowings(),
    );
  }
}

@riverpod
class GetFollowersNotifier extends _$GetFollowersNotifier {
  @override
  FutureOr<List<AuthorModel>> build() async {
    final repo = ref.read(followingRepositoryProvider);
    final followers = await repo.getMyFollowers();
    return followers;
  }
}

@riverpod
class MyFollowingBlogsNotifier extends _$MyFollowingBlogsNotifier {
  @override
  FollowingBlogsState build() {
    Future.microtask(() => firstFetchSaved());
    return FollowingBlogsState();
  }

  Future<void> firstFetchSaved({bool refresh = false}) async {
    if (state.isLoading) return;
    state = state.copyWith(
      status: PaginationStatus.loading,
      clearError: true,
      clearCursor: true,
      items: refresh ? [] : state.items,
    );
    try {
      final repo = ref.read(followingRepositoryProvider);
      final blogs = await repo.getMyFollowingBlogs();
      if (!ref.mounted) return;
      state = state.copyWith(
        items: blogs.data,
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
      final repo = ref.read(followingRepositoryProvider);
      final blogs = await repo.getMyFollowingBlogs(cursor: state.nextCursor);
      if (!ref.mounted) return;
      state = state.copyWith(
        items: [...state.items, ...blogs.data],
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
