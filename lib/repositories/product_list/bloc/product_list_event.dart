part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {}

class LoadProductList extends ProductListEvent {
  LoadProductList({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}