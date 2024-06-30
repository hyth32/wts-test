import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/features/models/models.dart';
import 'package:wts_test/repositories/category/category.dart';
import 'package:wts_test/repositories/product_list/product_list.dart';

part 'product_list_state.dart';
part 'product_list_event.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc(this.productListRepository, this.category) : super(ProductListInitial()) {
    on<LoadProductList>((event, emit) async {
      try {
        if (state is! ProductListStateLoaded) {
          emit(ProductListStateLoading());
        }
        final productList = await productListRepository.getProductList(
            categoryId: category?.categoryId);
        emit(ProductListStateLoaded(productList: productList));
      } catch (e) {
        emit(ProductListStateLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final Category? category;
  final AbstractProductListRepository productListRepository;
}
