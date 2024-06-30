import 'package:wts_test/features/models/models.dart';

abstract class AbstractProductDetailsRepository {
  Future<Product> getProductDetails(int productId);
}