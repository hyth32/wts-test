import 'models/models.dart';

abstract class AbstractCategoryRepository {
  Future<List<Category>> getCategoriesList();
}