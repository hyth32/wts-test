part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {}

class LoadProductDetails extends ProductDetailsEvent {
  LoadProductDetails({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
