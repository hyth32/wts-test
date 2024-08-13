import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

// part 'product_list_event.dart';

// TODO: базовый списочный блок для обработки всех данных, состояний и т.д.
class ProductListBloc
    extends BaseBloc<BaseBlocEvent, BlocState, List<Product>> {
  final Category? category;
  final AbstractProductListRepository productListRepository;

  List<Product> loadedData = [];
  bool isAllLoaded = false;

  int get offset => loadedData.length;

  ProductListBloc(
    this.productListRepository,
    this.category,
  ) : super(const InitialState()) {
    on<BaseBlockLoadEvent>(_onLoadProductList);
  }

  Future<void> _onLoadProductList(
    BaseBlockLoadEvent event,
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
    debugPrint(isAllLoaded.toString());
    isLoading = false;
    emit(DataFoundState(data: loadedData));
    event.completer?.complete();
  }
}
