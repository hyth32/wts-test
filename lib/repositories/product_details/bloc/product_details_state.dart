part of 'product_details_bloc.dart';

class ProductDetailsState extends BaseBlocState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends BaseBlocLoadingState implements ProductDetailsState {}

class ProductDetailsLoaded extends BaseBlocLoadedState<Product> implements ProductDetailsState {
  ProductDetailsLoaded(Product productDetails) : super([productDetails]);

  Product get productDetails => itemList[0];
}

class ProductDetailsLoadingFailure extends BaseBlocLoadingFailureState implements ProductDetailsState {
  ProductDetailsLoadingFailure({super.exception});
}
