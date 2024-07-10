import 'package:dio/dio.dart';
import 'package:wts_test/api/api.dart';
import 'package:wts_test/models/models.dart';
import 'product_list.dart';

class ProductListRepository implements AbstractProductListRepository {
  ProductListRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Product>> getProductList({int? categoryId, int? offset}) async {
    final response = await BaseApi(dio: dio).get('common/product/list',
        param: 'categoryId=$categoryId', offset: offset) as List<dynamic>;
    List<Product> productList =
        response.map((item) => Product.fromJSON(item)).toList();
    return productList;
  }
}
