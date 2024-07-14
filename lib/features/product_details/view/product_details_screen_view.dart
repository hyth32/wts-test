import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/abstract/base_refresh_scaffold.dart';
import 'package:wts_test/abstract/bloc/base_bloc_builder.dart';
import 'package:wts_test/features/product_details/widgets/product_details_tile.dart';
import 'package:wts_test/models/product_model.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';
import 'package:wts_test/repositories/product_details/bloc/product_details_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<StatefulWidget> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductDetailsBloc _productDetailsBloc;

  @override
  void initState() {
    super.initState();
    _productDetailsBloc = ProductDetailsBloc(
        GetIt.instance<AbstractProductDetailsRepository>(), widget.product.productId);
    _productDetailsBloc.add(LoadProductDetails());
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshScaffold(
      appBarTitle: widget.product.title,
      onRefresh: () async {
        final completer = Completer();
        _productDetailsBloc.add(LoadProductDetails(completer: completer));
        return completer.future;
      },
      body: BaseBlocBuilder<ProductDetailsBloc, ProductDetailsState, ProductDetailsLoaded>(
          buildContent: (context, state) {
              return ProductDetailsTile(product: state.productDetails);
          },
          bloc: _productDetailsBloc,
          onLoadingFailurePressed: () {
            _productDetailsBloc.add(LoadProductDetails());
          },
        ),
    );
  }
}
