part of 'product_details_bloc.dart';

abstract class ProductDetailsState extends Equatable {}

class ProductDetailsInitial extends ProductDetailsState {
  @override
  List<Object?> get props => [];
}

class ProductDetailsLoading extends ProductDetailsState {
  @override
  List<Object?> get props => [];
}

class ProductDetailsLoaded extends ProductDetailsState {
  ProductDetailsLoaded({required this.productDetails});

  final Product productDetails;

  @override
  List<Object?> get props => [productDetails];
}

class ProductDetailsLoadingFailure extends ProductDetailsState {
  ProductDetailsLoadingFailure({this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
