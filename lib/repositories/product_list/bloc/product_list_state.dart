part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {}

class ProductListInitial extends ProductListState {
  @override
  List<Object?> get props => [];
}

class ProductListStateLoading extends ProductListState {
  @override
  List<Object?> get props => [];
}

class ProductListStateLoaded extends ProductListState {
  ProductListStateLoaded({required this.productList});

  final List<Product> productList;

  @override
  List<Object?> get props => [productList];
}

class ProductListStateLoadingFailure extends ProductListState {
  ProductListStateLoadingFailure({this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}