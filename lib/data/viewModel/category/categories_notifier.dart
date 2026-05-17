import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/category/category_model.dart';
import 'package:tech_node/data/repository/categorys/category_repository.dart';

part 'categories_notifier.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  FutureOr<List<CategoryModel>> build() async {
    final repo = ref.read(categoryRepositoryProvider);
    return await repo.fetchBlogCategorys();
  }

  Future<void> refreshTheCategory() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(categoryRepositoryProvider).fetchBlogCategorys();
    });
  }
}
