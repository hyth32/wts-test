import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/features/product_details/widgets/product_details_tile.dart';
import 'package:wts_test/models/product_model.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';
import 'package:wts_test/repositories/product_details/bloc/product_details_bloc.dart';
import 'package:wts_test/widgets/loading_error.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title, style: Theme.of(context).textTheme.bodyLarge,),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: Colors.grey[850],
              height: 1,
            ),
          )
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _productDetailsBloc.add(LoadProductDetails(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoaded) {
              return ProductDetailsTile(product: state.productDetails);
            }
            if (state is ProductDetailsLoadingFailure) {
              return LoadingErrorWidget(onPressed: () {
                _productDetailsBloc.add(LoadProductDetails());
              });
            }
            return const Center(child: CircularProgressIndicator());
          },
          bloc: _productDetailsBloc,
        ),
      ),
    );
  }
}
