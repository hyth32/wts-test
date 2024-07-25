import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

part 'product_list_event.dart';

class ProductListBloc
    extends BaseBloc<ProductListEvent, BlocState, List<Product>> {
  final Category? category;
  final AbstractProductListRepository productListRepository;

  List<Product> loadedData = [];
  bool isAllLoaded = false;

  int get offset => loadedData.length;

  ProductListBloc(
    this.productListRepository,
    this.category,
  ) : super(const InitialState()) {
    on<LoadProductList>(_onLoadProductList);
  }

  Future<void> _onLoadProductList(
    LoadProductList event,
    Emitter<BlocState> emit,
  ) async {
    if (isLoading || isAllLoaded) return;
    isLoading = true;

    final result = await productListRepository.getProductList(
      categoryId: category?.categoryId,
      offset: offset,
    );

    if (result.isError) {
      isAllLoaded = true;
      emit(ErrorState(message: result.error!));
      return;
    }
    loadedData.addAll(result.data!);
    isAllLoaded = result.data!.isEmpty;
    isLoading = false;
    emit(DataFoundState(data: loadedData));
    event.completer?.complete();
  }
}
