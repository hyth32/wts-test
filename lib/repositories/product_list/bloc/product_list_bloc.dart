import 'dart:async';

import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/abstract/bloc/base_listview_bloc.dart';
import 'package:wts_test/api/entities/api_response.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

class ProductListBloc extends BaseListviewBloc<Product> {
  final Category? category;
  final AbstractProductListRepository productListRepository;

  ProductListBloc(
    this.productListRepository,
    this.category,
  ) : super(const InitialState());

  @override
  Future<ApiResponse<List<Product>>> fetchData() async {
    return productListRepository.getProductList(
      categoryId: category?.categoryId,
      offset: offset,
    );
  }
}
