import 'package:wts_test/models/models.dart';

abstract class AbstractProductDetailsRepository {
  Future<Product> getProductDetails(int productId);
}