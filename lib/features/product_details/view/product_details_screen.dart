import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/abstract/base_page.dart';
import 'package:wts_test/abstract/bloc/base_bloc_builder.dart';
import 'package:wts_test/features/product_details/widgets/product_details_tile.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';
import 'package:wts_test/repositories/product_details/bloc/product_details_bloc.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

class ProductDetailsScreen extends BasePage {
  ProductDetailsScreen({
    required this.product,
    super.key,
  }) : super(title: product.title);

  final Product product;

  @override
  State<StatefulWidget> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends BasePageState<ProductDetailsScreen> {
  late final ProductDetailsBloc _productDetailsBloc;

  @override
  void initState() {
    super.initState();
    _productDetailsBloc = ProductDetailsBloc(
        GetIt.I<AbstractProductDetailsRepository>(), widget.product.productId);
    _productDetailsBloc.add(LoadProductDetails());
  }

  @override
  Widget buildBody(BuildContext context) {
    return BaseBlocBuilder<ProductDetailsBloc, Product?>(
      buildContent: (context, state) {
        return ProductDetailsTile(product: state.data!);
      },
      bloc: _productDetailsBloc,
      onLoadingFailurePressed: () =>
          _productDetailsBloc.add(LoadProductDetails()),
    );
  }
}

// onRefresh: () async {
//         final completer = Completer();
//         _productDetailsBloc.add(LoadProductDetails(completer: completer));
//         return completer.future;
//       },