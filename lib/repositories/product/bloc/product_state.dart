part of 'product_bloc.dart';

abstract class ProductState extends Equatable {}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductStateLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductStateLoaded extends ProductState {
  ProductStateLoaded({required this.productList});

  final List<Product> productList;

  @override
  List<Object?> get props => [productList];
}

class ProductStateLoadingFailure extends ProductState {
  ProductStateLoadingFailure({this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}