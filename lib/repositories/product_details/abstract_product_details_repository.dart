import 'package:wts_test/models/product_model.dart';

abstract class AbstractProductDetailsRepository {
  Future<Product> getProductDetails(int productId);
}