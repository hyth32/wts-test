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

  ProductListScreen({
    required this.category,
    super.key,
  }) : super(
            title: category.title,
            shouldBeRefreshable: true,
            shouldBeSeparated: true,
            scrollController: ScrollController());

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends BaseListviewPageState<ProductListScreen> {
  late ProductListBloc _productListBloc;

  @override
  void initState() {
    super.initState();
    _productListBloc = ProductListBloc(
      GetIt.I<AbstractProductListRepository>(),
      widget.category,
    );
    _productListBloc.add(LoadProductList());
    widget.scrollController!.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;

    if (widget.scrollController!.position.atEdge) {
      if (widget.scrollController!.position.pixels ==
          widget.scrollController!.position.maxScrollExtent) {
        _productListBloc.add(LoadProductList());
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController!.removeListener(_onScroll);
    // widget.scrollController!.dispose();
    _productListBloc.close();
    super.dispose();
  }

  @override
  Widget buildListItem(BuildContext context, int index) {
    var product = _productListBloc.loadedData[index];
    return BaseNavigationTileWidget(
      pageToNavigate: ProductDetailsScreen(product: product),
      child: ProductTile(product: product),
    );
  }

  @override
  Widget buildListViewBody(BuildContext context) {
    return BaseBlocBuilder<ProductListBloc, List<Product>>(
      buildContent: (context, state) {
        return super.buildListViewBody(context);
      },
      bloc: _productListBloc,
      onLoadingFailurePressed: () => _productListBloc.add(LoadProductList()),
    );
  }

  @override
  Future<void> handleRefresh() {
    final completer = Completer();
    _productListBloc.add(LoadProductList(completer: completer));
    return completer.future;
  }

  @override
  int get itemCount => _productListBloc.loadedData.length;
}
