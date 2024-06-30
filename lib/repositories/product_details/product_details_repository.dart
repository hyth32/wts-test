import 'package:dio/dio.dart';
import 'package:wts_test/api/api.dart';
import 'package:wts_test/models/models.dart';

import 'product_details.dart';

class ProductDetailsRepository implements AbstractProductDetailsRepository {
  ProductDetailsRepository({required this.dio});

  final Dio dio;

  @override
  Future<Product> getProductDetails(int productId) async {
    final response = await BaseApi(dio: dio)
        .get('common/product/details', param: 'productId=$productId');
    final productDetails = Product.fromJSON(response);
    return productDetails;
  }
}
