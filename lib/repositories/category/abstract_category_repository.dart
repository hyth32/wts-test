import 'package:wts_test/repositories/category/models/category_model.dart';

abstract class AbstractCategoryRepository {
  Future<List<Category>> getCategoriesList();
}