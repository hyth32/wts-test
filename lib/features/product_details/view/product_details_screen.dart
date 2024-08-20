import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/abstract/base_details_page.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/features/product_details/widgets/product_details_tile.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';
import 'package:wts_test/repositories/product_details/bloc/product_details_bloc.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

class ProductDetailsScreen extends BaseDetailsPage {
  ProductDetailsScreen({
    required this.product,
    super.key,
  }) : super(title: product.title);

  final Product product;

  @override
  State<StatefulWidget> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends BaseDetailsPageState<ProductDetailsScreen, ProductDetailsBloc> {
  @override
  ProductDetailsBloc createModel() => ProductDetailsBloc(
      GetIt.I<AbstractProductDetailsRepository>(), widget.product.productId);

  @override
  Widget buildItem(BuildContext context, DataFoundState<Product?> state) {
    return ProductDetailsTile(
      title: state.data!.title,
      imageUrl: state.data!.imageUrl,
      price: state.data!.price,
      product: state.data!,
    );
  }
}
