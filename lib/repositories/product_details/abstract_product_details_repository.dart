import 'package:wts_test/repositories/product_list/models/product_model.dart';

abstract class AbstractProductDetailsRepository {
  Future<Product> getProductDetails(int productId);
}