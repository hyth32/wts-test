import 'package:get_it/get_it.dart';
import 'package:wts_test/api/api_response_parser.dart';
import 'package:wts_test/api/base_api/base_api.dart';
import 'package:wts_test/api/entities/api_response.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

class ProductListRepository implements AbstractProductListRepository {
  @override
  Future<ApiResponse<List<Product>>> getProductList({
    int? categoryId,
    int? offset,
  }) async {
    final queryParameters = {
      'categoryId': '$categoryId',
      'offset': '$offset',
    };
    final response = await GetIt.I<BaseApi>().get(
      'common/product/list',
      queryParameters: queryParameters,
    );
    return ApiResponseParser.parseListFromResponse(
      response,
      fromJson: Product.fromJson,
    );
  }
}
