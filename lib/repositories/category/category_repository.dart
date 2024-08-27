import 'package:get_it/get_it.dart';
import 'package:wts_test/api/api_response_parser.dart';
import 'package:wts_test/api/base_api/base_api.dart';
import 'package:wts_test/api/entities/api_response.dart';
import 'package:wts_test/repositories/category/abstract_category_repository.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';

class CategoryRepository implements AbstractCategoryRepository {
  static const Category allProductsCategory = Category(
    categoryId: 0,
    title: 'Все товары',
    hasSubcategories: 0,
    fullName: 'Все товары',
    categoryDescription: 'Все товары в каталоге',
  );

  @override
  Future<ApiResponse<List<Category>>> getCategoriesList() async {
    final response = await GetIt.I<BaseApi>().get(
      'common/category/list',
    );

    final parsedResponse = ApiResponseParser.parseListFromResponse(
      response,
      key: 'categories',
      fromJson: Category.fromJson,
    );

    if (parsedResponse.data != null) {
      parsedResponse.data!.insert(0, allProductsCategory);
    }

    return parsedResponse;
  }
}
