import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/error/blog_exception.dart';
import 'package:tech_node/core/error/dio_exception_handler.dart';
import 'package:tech_node/data/model/blog/blogs_detail_model.dart';
import 'package:tech_node/data/model/pagination/paginated_response_model.dart';
import 'package:tech_node/data/model/blog/blogs_preview_model.dart';
import 'package:tech_node/data/model/ui/create_blog_data_model.dart';
import 'package:tech_node/data/model/user/user_model.dart';
import 'package:tech_node/core/network/dio_provider.dart';

part 'blog_post_repository.g.dart';

abstract class BlogPostRepository {
  Future<PaginatedResponseModel<BlogsPreviewModel>> fetchBlogIndex({
    String? cursor,
  });
  Future<BlogsDetailModel> fetchBlogDetail({required String id});
  Future<String> addBlogViewCount({required String id});
  Future<String> createBlogForPost({required CreateBlogDataModel theData});
  Future<AuthorProfileModel> seeAuthorProfile({required String authorID});
  Future<String> updateBlogForPost({
    required CreateBlogDataModel theData,
    required int blogId,
  });
  Future<String> deleteMyBlog({required int blogId});
  Future<PaginatedResponseModel<BlogsPreviewModel>> getMyPostedBlogs({
    String? cursor,
  });
}

@riverpod
BlogPostRepository blogPostRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return BlogPostRepositoryImp(dio);
}

class BlogPostRepositoryImp implements BlogPostRepository {
  final Dio _dio;
  BlogPostRepositoryImp(this._dio);
  @override
  Future<PaginatedResponseModel<BlogsPreviewModel>> fetchBlogIndex({
    String? cursor,
  }) async {
    try {
      final response = await _dio.get(
        'posts',
        queryParameters: {'cursor': ?cursor},
      );
      if (response.data['status'] == 'Success' && response.statusCode == 200) {
        final List data = response.data['data'];
        final String? nextCursor = response.data['next_cursor'];
        final bool hasMore = response.data['has_more_pages'];
        final List layout = response.data['layout'];
        final items = data
            .map((json) => BlogsPreviewModel.fromJson(json))
            .toList();
        return PaginatedResponseModel(
          data: items,
          hasMorePages: hasMore,
          nextCursor: nextCursor,
          layout: layout
        );
      }

      throw BlogException("Failed to load blogs");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<BlogsDetailModel> fetchBlogDetail({required String id}) async {
    try {
      final response = await _dio.get('posts/$id');
      if (response.data['status'] == 'Success' && response.statusCode == 200) {
        final data = response.data['data'];
        return BlogsDetailModel.fromJson(data);
      }

      throw BlogException("Failed to load blog");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<String> addBlogViewCount({required String id}) async {
    try {
      final response = await _dio.post('posts/views', data: {'post_id': id});
      if (response.data['status'] == 'Success' && response.statusCode == 200) {
        debugPrint('--------------->>>>>> ${response.data['message']}');
        return 'view counted';
      }
      throw BlogException("Failed to count view");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<String> createBlogForPost({
    required CreateBlogDataModel theData,
  }) async {
    final Map<String, dynamic> mappedData = {
      'title': theData.blogTitle,
      'category_id': theData.blogCategory,
      'content': theData.blogContent,
      'hashtags': theData.hashtags,
    };
    final formData = FormData.fromMap(mappedData);
    if (theData.blogThumbnailPath != null) {
      formData.files.add(
        MapEntry(
          'thumbnail',
          await MultipartFile.fromFile(
            theData.blogThumbnailPath!,
            filename: 'thumbnail.webp',
          ),
        ),
      );
    }
    try {
      final response = await _dio.post('posts', data: formData);
      if (response.data['status'] == 'Success' && response.statusCode == 201) {
        return 'blog created';
      }
      throw BlogException("Failed to create blog");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<AuthorProfileModel> seeAuthorProfile({
    required String authorID,
  }) async {
    try {
      final response = await _dio.get('posts/$authorID/author-profile');
      if (response.data['status'] == 'Success' && response.statusCode == 200) {
        return AuthorProfileModel.fromJson(response.data['data']);
      }
      throw BlogException("Failed to fetch author profile");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }


  @override
  Future<String> updateBlogForPost({
    required CreateBlogDataModel theData,
    required int blogId,
  }) async {
    final Map<String, dynamic> mappedData = {
      'title': theData.blogTitle,
      'category_id': theData.blogCategory,
      'content': theData.blogContent,
      'hashtags': theData.hashtags,
    };
    final formData = FormData.fromMap(mappedData);
    if (theData.blogThumbnailPath != null) {
      formData.files.add(
        MapEntry(
          'thumbnail',
          await MultipartFile.fromFile(
            theData.blogThumbnailPath!,
            filename: 'thumbnail.webp',
          ),
        ),
      );
    }
    try {
      final response = await _dio.put('posts/$blogId', data: formData);
      if (response.data['status'] == 'Success' && response.statusCode == 200) {
        return 'blog updated';
      }
      throw BlogException("Failed to update blog");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<String> deleteMyBlog({required int blogId}) async {
    try {
      final response = await _dio.delete('posts/$blogId');
      if (response.data['status'] == 'Success' && response.statusCode == 200) {
        return response.data['message'];
      }
      throw BlogException("Failed to delete blog");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
  @override
  Future<PaginatedResponseModel<BlogsPreviewModel>> getMyPostedBlogs({
    String? cursor,
  })async{
      try {
      final response = await _dio.get(
        'posts/my-blogs',
        queryParameters: {'cursor': ?cursor},
      );
      if (response.data['status'] == 'Success' && response.statusCode == 200) {
        final List data = response.data['blogs'];
        final String? nextCursor = response.data['next_cursor'];
        final bool hasMore = response.data['has_more_pages'];
        final List layout = response.data['layout'];
        final items = data
            .map((json) => BlogsPreviewModel.fromJson(json))
            .toList();
        return PaginatedResponseModel(
          data: items,
          hasMorePages: hasMore,
          nextCursor: nextCursor,
          layout: layout
        );
      }

      throw BlogException("Failed to load blogs");
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
}
