import 'package:wts_test/api/entities/api_response.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

abstract class AbstractProductDetailsRepository {
  Future<ApiResponse<Product>> getProductDetails(int productId);
}
