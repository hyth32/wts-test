import 'models/models.dart';

abstract class AbstractProductRepository {
  Future<List<Product>> getProductsList({int? categoryId});
}