import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/repositories/category/category.dart';
import 'package:wts_test/repositories/product/product.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this.productRepository, this.category) : super(ProductInitial()) {
    on<LoadProductList>((event, emit) async {
      try {
        emit(ProductStateLoading());
        final productList = await productRepository.getProductsList(
            categoryId: category?.categoryId);
        emit(ProductStateLoaded(productList: productList));
      } catch (e) {
        emit(ProductStateLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final Category? category;
  final AbstractProductRepository productRepository;
}
