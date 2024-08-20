import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/abstract/base_listview_page.dart';
import 'package:wts_test/abstract/base_navigation_tile_widget.dart';
import 'package:wts_test/features/product_details/view/product_details_screen.dart';
import 'package:wts_test/features/products_list/widgets/product_tile.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/bloc/product_list_bloc.dart';

class ProductListScreen extends BaseListviewPage {
  final Category category;

  //Q: вернул `: super(title: category.title)`, пока не представляю, как по другому передать title в конструктор
  ProductListScreen({
    required this.category,
    super.key,
  }) : super(title: category.title);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState
    extends BaseListviewPageState<ProductListScreen, ProductListBloc> {
  @override
  bool get shouldBeSeparated => !super.shouldBeSeparated;

  @override
  bool get shouldBeRefreshable => !super.shouldBeRefreshable;

  @override
  ProductListBloc createModel() => ProductListBloc(
        GetIt.I<AbstractProductListRepository>(),
        widget.category,
      );

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
  int get itemCount => listModel.loadedData.length;
}
