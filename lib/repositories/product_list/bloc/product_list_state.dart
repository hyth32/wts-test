part of 'product_list_bloc.dart';

class ProductListState extends BaseBlocState {}

class ProductListInitial extends ProductListState {}

class ProductListStateLoading extends BaseBlocLoadingState implements ProductListState {}

class ProductListStateLoaded extends BaseBlocLoadedState<Product> implements ProductListState {
  ProductListStateLoaded(super.productList, this.hasMore);

  final bool hasMore;
  List<Product> get productList => itemList;
}

class ProductListStateLoadingFailure extends BaseBlocLoadingFailureState implements ProductListState {
  ProductListStateLoadingFailure({super.exception});
}