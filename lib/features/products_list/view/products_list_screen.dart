import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/abstract/base_listview_page.dart';
import 'package:wts_test/abstract/base_navigation_tile_widget.dart';
import 'package:wts_test/abstract/bloc/base_bloc_builder.dart';
import 'package:wts_test/features/product_details/view/product_details_screen.dart';
import 'package:wts_test/features/products_list/widgets/product_tile.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/bloc/product_list_bloc.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

class ProductListScreen extends BaseListviewPage {
  final Category category;

  const ProductListScreen({
    required this.category,
    super.key,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState
    extends BaseListviewPageState<ProductListScreen, ProductListBloc> {
  @override
  ProductListBloc createModel() => ProductListBloc(
        GetIt.I<AbstractProductListRepository>(),
        widget.category,
      );

  // TODO: можно в BaseListviewPageState, ProductListBloc будет наследовать базовый блок для списков
  @override
  void loadMore() {
    listModel.add(LoadProductList());
  }

  @override
  Widget buildListItem(BuildContext context, int index) {
    final product = listModel.loadedData[index];
    return BaseNavigationTileWidget(
      pageToNavigate: ProductDetailsScreen(product: product),
      child: ProductTile(
        title: product.title,
        imageUrl: product.imageUrl,
        price: product.price,
      ),
    );
  }

  @override
  Widget buildListViewBody(BuildContext context) {
    //TODO: Можно в BaseListviewPageState
    return BaseBlocBuilder<ProductListBloc, List<Product>>(
      buildContent: (context, state) {
        return super.buildListViewBody(context);
      },
      bloc: listModel,
      onLoadingFailurePressed: () => listModel.add(LoadProductList()),
    );
  }

  @override
  Future<void> handleRefresh() {
    //TODO: Можно в BaseListviewPageState
    final completer = Completer();
    listModel.add(LoadProductList(completer: completer));
    return completer.future;
  }

  @override
  int get itemCount => listModel.loadedData.length;
}
