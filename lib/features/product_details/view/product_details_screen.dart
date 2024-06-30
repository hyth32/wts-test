import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/features/product_details/widgets/widgets.dart';
import 'package:wts_test/models/models.dart';
import 'package:wts_test/repositories/product_details/bloc/product_details_bloc.dart';
import 'package:wts_test/repositories/product_details/product_details.dart';
import 'package:wts_test/widgets/widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Product product;
  late ProductDetailsBloc _productDetailsBloc;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is Product, 'Invalid arguments');
    product = args as Product;

    _productDetailsBloc = ProductDetailsBloc(
        GetIt.instance<AbstractProductDetailsRepository>(), product.productId);
    _productDetailsBloc.add(LoadProductDetails());

    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, style: Theme.of(context).textTheme.bodyLarge,),
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
