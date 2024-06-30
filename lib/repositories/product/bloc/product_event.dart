part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {}

class LoadProductList extends ProductEvent {
  LoadProductList({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}