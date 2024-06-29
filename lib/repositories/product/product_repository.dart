import 'package:dio/dio.dart';
import 'package:wts_test/api/api.dart';
import 'product.dart';

class ProductRepository implements AbstractProductRepository {
  ProductRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Product>> getProductsList({int? categoryId}) async {
    final response = await BaseApi(dio: dio).get('common/product/list', categoryId: categoryId) as List<dynamic>;
    List<Product> items = response.map((item) => Product.fromJSON(item)).toList();
    return items;
  }
}