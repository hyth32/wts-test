import 'package:wts_test/api/entities/api_response.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';

abstract class AbstractCategoryRepository {
  Future<ApiResponse<List<Category>>> getCategoriesList();
}
