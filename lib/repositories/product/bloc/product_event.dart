part of 'product_bloc.dart';

class ProductEvent {}

class LoadProductList extends ProductEvent {
  LoadProductList({this.completer});

  final Completer? completer;
}