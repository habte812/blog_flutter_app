import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/error/blog_exception.dart';
import 'package:tech_node/core/error/dio_exception_handler.dart';
import 'package:tech_node/data/model/category/category_model.dart';
import 'package:tech_node/core/network/dio_provider.dart';

part 'category_repository.g.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> fetchBlogCategorys();
}

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CategoryRepositoryImp(dio);
}

class CategoryRepositoryImp implements CategoryRepository {
  final Dio _dio;
  CategoryRepositoryImp(this._dio);

  @override
  Future<List<CategoryModel>> fetchBlogCategorys() async {
    try {
      final response = await _dio.get('categories');
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        final List data = response.data['data'];
        return data.map((cat) => CategoryModel.fromJson(cat)).toList();
      }
      throw BlogException('Failed to load categories');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }
}
