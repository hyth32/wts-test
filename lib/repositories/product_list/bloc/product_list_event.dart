part of 'product_list_bloc.dart';

class ProductListEvent extends BaseBlocEvent {}

class LoadProductList extends BaseBlockLoadEvent implements ProductListEvent {
  LoadProductList({super.completer});
}
