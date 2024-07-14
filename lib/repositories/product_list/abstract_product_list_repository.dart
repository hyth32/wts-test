import 'package:wts_test/repositories/product_list/models/product_model.dart';

abstract class AbstractProductListRepository {
  Future<List<Product>> getProductList({int? categoryId, int? offset});
}
