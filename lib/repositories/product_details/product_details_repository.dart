import 'package:get_it/get_it.dart';
import 'package:wts_test/api/base_api.dart';
import 'package:wts_test/models/product_model.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';

class ProductDetailsRepository implements AbstractProductDetailsRepository {
  @override
  Future<Product> getProductDetails(int productId, {int? offset}) async {
    var queryParameters = {
      'productId': '$productId',
      'offset': '$offset',
    };
        final response = await GetIt.instance<BaseApi>()
          .get('common/product/details', queryParameters: queryParameters);
        final productDetails = Product.fromJSON(response);
        return productDetails;
  }
}