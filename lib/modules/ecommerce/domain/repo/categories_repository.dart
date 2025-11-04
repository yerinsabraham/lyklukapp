import '../../../../core/shared/resources/typedefs.dart';
import '../../model/category_model.dart';

abstract class CategoriesRepository {
  /// get all categoties
  FutureResponse<List<CategoryModel>> getAllCategories();

  ///  get root categories
  FutureResponse<List<CategoryModel>> getRootCategories();

  /// get  categories id
  FutureResponse<CategoryModel> getCategoriesId({required int id});
}

