import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/error/blog_exception.dart';
import 'package:tech_node/core/error/dio_exception_handler.dart';
import 'package:tech_node/core/network/dio_provider.dart';
import 'package:tech_node/data/model/comment/blog_comment_model.dart';

part 'comments_repository.g.dart';

abstract class CommentsRepository {
  Future<List<BlogCommentModel>> getParentComments({required String postId});
  Future<List<BlogCommentModel>> getRepliesComment({required String parentId});
  Future<BlogCommentModel> writeComment({
    required String postId,
    required String content,
    String? parentId,
  });
  Future<String> deleteComment({required int commentId});
}

@riverpod
CommentsRepository commentsRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CommentsRepositoryImp(dio);
}

class CommentsRepositoryImp implements CommentsRepository {
  final Dio _dio;
  CommentsRepositoryImp(this._dio);
  @override
  Future<List<BlogCommentModel>> getParentComments({
    required String postId,
  }) async {
    try {
      final response = await _dio.get('posts/$postId/comments');
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        final List data = response.data['data'];
        return data.map((com) => BlogCommentModel.fromJson(com)).toList();
      }
      throw BlogException('Unable to fetch comments');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<List<BlogCommentModel>> getRepliesComment({
    required String parentId,
  }) async {
    try {
      final response = await _dio.get('posts/$parentId/replies');
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        final List data = response.data['data'];
        return data.map((com) => BlogCommentModel.fromJson(com)).toList();
      }
      throw BlogException('Unable to fetch replies');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<BlogCommentModel> writeComment({
    required String postId,
    required String content,
    String? parentId,
  }) async {
    try {
      final response = await _dio.post(
        'posts/comments',
        data: {'post_id': postId, 'content': content, 'parent_id': parentId},
      );

      if (response.statusCode == 201 && response.data['status'] == 'Success') {
        return BlogCommentModel.fromJson(response.data['data']);
      }

      throw BlogException('Unable to add comment');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
    @override
  Future<String> deleteComment({
    required int commentId,
  }) async {
    try {
      final response = await _dio.delete(
        'posts/comments/$commentId',
      );

      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return response.data['message'];
      }

      throw BlogException('Unable to delete comment');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
}
