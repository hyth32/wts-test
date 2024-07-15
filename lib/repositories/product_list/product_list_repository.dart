import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/api/base_api.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

class ProductListRepository implements AbstractProductListRepository {
  @override
  Future<List<Product>> getProductList({int? categoryId, int? offset}) async {
    var queryParameters = {
      'categoryId': '$categoryId',
      'offset': '$offset',
    };
    try {
      final response = await GetIt.I<BaseApi>().get(
        'common/product/list',
        queryParameters: queryParameters,
      ) as List<dynamic>;
      List<Product> productList = response
          .map((item) => Product.fromJson(item)).toList();
      return productList;
    } catch (e) {
      debugPrint('Exception: $e');
      return <Product>[];
    }
  }
}
