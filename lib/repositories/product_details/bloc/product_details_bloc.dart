import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/models/product_model.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc(this.productDetailsRepository, this.productId) : super(ProductDetailsInitial()) {
    on<LoadProductDetails>((event, emit) async {
      try {
        if (state is! ProductDetailsLoaded) {
          emit(ProductDetailsLoading());
        }
        final productDetails = await productDetailsRepository.getProductDetails(productId);
        emit(ProductDetailsLoaded(productDetails));
      } catch (e) {
        emit(ProductDetailsLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final AbstractProductDetailsRepository productDetailsRepository;
  final int productId;
}
