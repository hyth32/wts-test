import 'package:get_it/get_it.dart';
import 'package:wts_test/api/api_response_parser.dart';
import 'package:wts_test/api/base_api/base_api.dart';
import 'package:wts_test/api/entities/api_response.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

class ProductDetailsRepository implements AbstractProductDetailsRepository {
  @override
  Future<ApiResponse<Product>> getProductDetails(int productId) async {
    final queryParameters = {
      'productId': '$productId',
    };
    final response = await GetIt.I<BaseApi>().get(
      'common/product/details',
      queryParameters: queryParameters,
    );
    return ApiResponseParser.parseObjectFromResponse(
      response,
      fromJson: Product.fromJson,
    );
  }
}
