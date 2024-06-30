import '../../features/models/models.dart';

abstract class AbstractProductListRepository {
  Future<List<Product>> getProductList({int? categoryId});
}