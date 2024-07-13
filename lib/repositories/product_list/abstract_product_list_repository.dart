import 'package:wts_test/models/product_model.dart';

abstract class AbstractProductListRepository {
  Future<List<Product>> getProductList({int? categoryId, int? offset});
}
