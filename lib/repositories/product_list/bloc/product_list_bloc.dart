import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

part 'product_list_state.dart';
part 'product_list_event.dart';

class ProductListBloc extends BaseBloc<ProductListEvent, ProductListState, Product> {
  ProductListBloc(this.productListRepository, this.category) : super(ProductListInitial()) {
    on<LoadProductList>(_onLoadProductList);
    on<LoadMoreProducts>(_onLoadMoreProducts);
  }

  final Category? category;
  final AbstractProductListRepository productListRepository;
  int offset = 0;
  bool isLoading = false;

  Future<void> _onLoadProductList(LoadProductList event, Emitter<ProductListState> emit) async {
    await loadItems(
        emit: emit,
        loadItemsFunction: () async {
          final productList =
            await productListRepository.getProductList(
                categoryId: category?.categoryId,
                offset: 0,
            );
          offset = productList.length;
          return productList;
        },
        loadedState: (items, hasMoreItems) =>
            ProductListStateLoaded(items, hasMoreItems),
        loadingFailureState: (exception) => ProductListStateLoadingFailure(exception: exception),
    );
    event.completer?.complete();
  }

  Future<void> _onLoadMoreProducts(
      LoadMoreProducts event, Emitter<ProductListState> emit) async {
    if (isLoading) return;
    isLoading = true;
    try {
      final currentState = state;
      if (currentState is ProductListStateLoaded) {
        debugPrint('Loading more products...');
        final productList = await productListRepository.getProductList(
            categoryId: category?.categoryId, offset: offset);
        offset += productList.length;
        final updatedProductList =
        List<Product>.from(currentState.productList)..addAll(productList);
        emit(ProductListStateLoaded(updatedProductList, productList.isNotEmpty));
        debugPrint('Loaded ${productList.length} additional products.');
      }
    } catch (e) {
      emit(ProductListStateLoadingFailure(exception: e));
    } finally {
      isLoading = false;
    }
  }
}
