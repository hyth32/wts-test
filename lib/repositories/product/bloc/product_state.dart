part of 'product_bloc.dart';

class ProductState {}

class ProductInitial extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateLoaded extends ProductState {
  ProductStateLoaded({required this.productList});

  final List<Product> productList;
}

class ProductStateLoadingFailure extends ProductState {
  ProductStateLoadingFailure({this.exception});

  final Object? exception;
}