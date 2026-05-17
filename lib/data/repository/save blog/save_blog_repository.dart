
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/error/blog_exception.dart';
import 'package:tech_node/core/error/dio_exception_handler.dart';
import 'package:tech_node/core/network/dio_provider.dart';
import 'package:tech_node/data/model/blog/blogs_preview_model.dart';
import 'package:tech_node/data/model/pagination/paginated_response_model.dart';

part 'save_blog_repository.g.dart';

abstract class SaveBlogRepository {
  Future<bool> saveTheBlog({required int blogId});
  Future<PaginatedResponseModel<BlogsPreviewModel>> getMySavedBlogs({
    String? cursor,
  });
}

@riverpod
SaveBlogRepository saveBlogRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return SaveBlogRepositoryImp(dio);
}

class SaveBlogRepositoryImp implements SaveBlogRepository {
  final Dio _dio;

  SaveBlogRepositoryImp(this._dio);

  @override
  Future<bool> saveTheBlog({required int blogId}) async {
    try {
      final response = await _dio.post('post/$blogId/save');

      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return response.data['is_saved'] ?? false;
      }

      throw BlogException('Faild to save blog');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<PaginatedResponseModel<BlogsPreviewModel>> getMySavedBlogs({
    String? cursor,
  }) async {
    try {
      final response = await _dio.get(
        'post/saved-blogs',
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
