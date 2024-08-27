import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/abstract/bloc/list_bloc/base_list_bloc.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

class ProductListBloc extends BaseListBloc<BlocState, Product> {
  final Category? category;
  final AbstractProductListRepository productListRepository;

  ProductListBloc(
    this.productListRepository,
    this.category,
  );

  @override
  Future<void> loadNextItems(
    BaseBlocEvent event,
    Emitter<BlocState> emit,
  ) async {
    final result = await productListRepository.getProductList(
      categoryId: category?.categoryId,
      offset: offset,
    );
    if (result.isError) {
      onLoadingError(result.error, emit);
    } else {
      await onNextItemsLoaded(result.data!, event, emit);
    }
  }
}
