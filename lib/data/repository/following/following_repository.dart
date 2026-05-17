import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/error/blog_exception.dart';
import 'package:tech_node/core/error/dio_exception_handler.dart';
import 'package:tech_node/core/network/dio_provider.dart';
import 'package:tech_node/data/model/author/author_model.dart';
import 'package:tech_node/data/model/blog/blogs_preview_model.dart';
import 'package:tech_node/data/model/pagination/paginated_response_model.dart';

part 'following_repository.g.dart';

abstract class FollowingRepository {
  Future<bool> followAuthor({required String authorID});
  Future<List<AuthorModel>> getMyFollowings();
  Future<List<AuthorModel>> getMyFollowers();
  Future<PaginatedResponseModel<BlogsPreviewModel>> getMyFollowingBlogs({String? cursor});
}

@riverpod
FollowingRepository followingRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return FollowingRepositoryImp(dio);
}

class FollowingRepositoryImp implements FollowingRepository {
  final Dio _dio;
  FollowingRepositoryImp(this._dio);

  @override
  Future<bool> followAuthor({required String authorID}) async {
    try {
      final response = await _dio.post('posts/$authorID/follow');
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return response.data['is_following'] ?? false;
      }
      throw BlogException('Unable to follow author, try later');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
  @override
  Future<List<AuthorModel>> getMyFollowings() async {
    try {
      final response = await _dio.get('posts/my/followings');
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        final List data = response.data['followings'];
        return data
            .map((json) => AuthorModel.fromJson(json))
            .toList();
      }
      throw BlogException("Failed to load followings");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
  @override
  Future<List<AuthorModel>> getMyFollowers() async {
    try {
      final response = await _dio.get('posts/my/followers');
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        final List data = response.data['followers'];
        return data
            .map((json) => AuthorModel.fromJson(json))
            .toList();
      }
      throw BlogException("Failed to load followers");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
    @override
  Future<PaginatedResponseModel<BlogsPreviewModel>> getMyFollowingBlogs({String? cursor})async{
       try {
      final response = await _dio.get(
        'posts/my/followings/blogs',
        queryParameters: {'cursor': ?cursor},
      );

      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        final List data = response.data['blogs'];
        final List<BlogsPreviewModel> items = data
            .map((json) => BlogsPreviewModel.fromJson(json))
            .toList();
        return PaginatedResponseModel<BlogsPreviewModel>(
          data: items,
          nextCursor: response.data['next_cursor'],
          hasMorePages: response.data['has_more_pages'],
          layout: response.data['layout']
        );
      }

      throw BlogException("Failed to load blogs");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

}
