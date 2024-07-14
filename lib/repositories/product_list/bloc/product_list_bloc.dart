import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/models/product_model.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';

part 'product_list_state.dart';
part 'product_list_event.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc(this.productListRepository, this.category)
      : super(ProductListInitial()) {
    on<LoadProductList>(_onLoadProductList);
    on<LoadMoreProducts>(_onLoadMoreProducts);
  }

  final Category? category;
  final AbstractProductListRepository productListRepository;
  int offset = 0;
  bool isLoading = false;

  Future<void> _onLoadProductList(
      LoadProductList event, Emitter<ProductListState> emit) async {
    try {
      final productList = await productListRepository.getProductList(
          categoryId: category?.categoryId, offset: 0);
      offset = productList.length;
      emit(ProductListStateLoaded(productList, productList.isNotEmpty));
      debugPrint('Loaded ${productList.length} products.');
    } catch (e) {
      emit(ProductListStateLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
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
