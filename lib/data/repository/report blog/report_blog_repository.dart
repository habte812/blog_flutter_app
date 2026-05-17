import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/error/blog_exception.dart';
import 'package:tech_node/core/error/dio_exception_handler.dart';
import 'package:tech_node/core/network/dio_provider.dart';
import 'package:tech_node/data/model/report%20blog/report_blog_model.dart';

part 'report_blog_repository.g.dart';

abstract class ReportBlogRepository {
  Future<String> reportblog({required ReportBlogModel reportData});
}

@riverpod
ReportBlogRepository reportBlogRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ReportBlogRepositoryImp(dio);
}

class ReportBlogRepositoryImp implements ReportBlogRepository {
  final Dio _dio;

  ReportBlogRepositoryImp(this._dio);
  @override
  Future<String> reportblog({required ReportBlogModel reportData}) async {
    try {
      final response = await _dio.post(
        'posts/${reportData.blogId}/report',
        data: {'reason': reportData.reason, 'details': reportData.detail},
      );
      if (response.statusCode == 201 && response.data['status'] == 'Success') {
        return response.data['message'];
      }
      throw BlogException('Failed to submit report');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
}
