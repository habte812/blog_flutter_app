import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';
import 'package:tech_node/data/model/ui/create_blog_data_model.dart';
import 'package:tech_node/data/model/user/user_model.dart';
import 'package:tech_node/data/repository/blog/blog_post_repository.dart';

part 'blog_detail_notifier.g.dart';

@riverpod
class BlogDetailNotifier extends _$BlogDetailNotifier {
  @override
  FutureOr<BlogsDetailModel?> build(String id) async {
    final keepMe = ref.keepAlive();
    Timer(const Duration(minutes: 1), () => keepMe.close());
    return await ref.read(blogPostRepositoryProvider).fetchBlogDetail(id: id);
  }

  Future<void> refreshThePage(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(blogPostRepositoryProvider).fetchBlogDetail(id: id);
    });
  }
}

@riverpod
Future<void> addBlogView(Ref ref, {required String id}) async {
  final keep = ref.keepAlive();
  try {
    await ref.read(blogPostRepositoryProvider).addBlogViewCount(id: id);
    // ignore: empty_catches
  } catch (e) {
  } finally {
    Timer(const Duration(minutes: 1), () => keep.close());
  }
}

@riverpod
class CreateBlogNotifier extends _$CreateBlogNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> createBlog({required CreateBlogDataModel data}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(blogPostRepositoryProvider)
          .createBlogForPost(theData: data);
    });
  }
}

@riverpod
class SeeAuthorProfile extends _$SeeAuthorProfile {
  @override
  FutureOr<AuthorProfileModel> build(String authorID) {
    final keepMe = ref.keepAlive();
    Timer(const Duration(seconds: 5), () => keepMe.close());
    return ref
        .read(blogPostRepositoryProvider)
        .seeAuthorProfile(authorID: authorID);
  }

  Future<void> refreshProfile(String authorID) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(blogPostRepositoryProvider)
          .seeAuthorProfile(authorID: authorID),
    );
  }
}

@riverpod
class UpdateMyPublishedBlog extends _$UpdateMyPublishedBlog {
  @override
  FutureOr<void> build() {}

  Future<void> updateBlog({
    required CreateBlogDataModel data,
    required int blogId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(blogPostRepositoryProvider)
          .updateBlogForPost(theData: data, blogId: blogId);
    });
  }
}

@riverpod
class DeleteMyPublishedBlog extends _$DeleteMyPublishedBlog {
  @override
  FutureOr<String?> build() {
    return 'Loading...';
  }

  Future<String> deleteBlog({required int blogId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final resp = await ref
          .read(blogPostRepositoryProvider)
          .deleteMyBlog(blogId: blogId);
      return resp;
    });
    if(state.value != null){
      return state.value!;
    }

    return "Something went wrong";
  }
}
