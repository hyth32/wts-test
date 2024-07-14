part of 'product_details_bloc.dart';

class ProductDetailsEvent extends BaseBlocEvent {}

class LoadProductDetails extends BaseBlockLoadEvent implements ProductDetailsEvent {
  LoadProductDetails({super.completer});
}