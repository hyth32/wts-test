part of 'product_bloc.dart';

class ProductState {}

class ProductInitial extends ProductState {}

class ProductStateLoaded extends ProductState {
  ProductStateLoaded({required this.productList});

  final List<Product> productList;
}