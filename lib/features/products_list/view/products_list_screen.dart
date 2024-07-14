  import 'dart:async';
  
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:get_it/get_it.dart';
import 'package:wts_test/abstract/base_refresh_scaffold.dart';
    import 'package:wts_test/features/product_details/view/product_details_screen_view.dart';
  import 'package:wts_test/features/products_list/widgets/product_tile.dart';
  import 'package:wts_test/repositories/category/models/category_model.dart';
  import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
  import 'package:wts_test/repositories/product_list/bloc/product_list_bloc.dart';
  import 'package:wts_test/widgets/loading_error.dart';
  
  class ProductListScreen extends StatefulWidget {
    const ProductListScreen({super.key, required this.category});
    final Category category;
  
    @override
    State<StatefulWidget> createState() => _ProductListScreenState();
  }
  
  class _ProductListScreenState extends State<ProductListScreen> {
    late ProductListBloc _productListBloc;
    final ScrollController _scrollController = ScrollController();
  
    @override
    void initState() {
      super.initState();
      _productListBloc = ProductListBloc(
          GetIt.instance<AbstractProductListRepository>(),
          widget.category,
      );
      _productListBloc.add(LoadProductList());
  
      _scrollController.addListener(_onScroll);
    }
  
    void _onScroll() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _productListBloc.add(LoadMoreProducts());
      }
    }
  
    @override
    void dispose() {
      _scrollController.removeListener(_onScroll);
      _scrollController.dispose();
      _productListBloc.close();
      super.dispose();
    }
  
    @override
    Widget build(BuildContext context) {
      return BaseRefreshScaffold(
        appBarTitle: widget.category.title,
        onRefresh: () async {
          final completer = Completer();
          _productListBloc.add(LoadProductList(completer: completer));
          return completer.future;
        },
        body: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListStateLoaded) {
                return ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 16),
                  padding: const EdgeInsets.all(16),
                  itemCount: state.productList.length,
                  itemBuilder: (context, index) {
                    if (index >= state.productList.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final product = state.productList[index];
                    return ProductTile(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ProductDetailsScreen(product: product,)),
                        );
                      },
                    );
                  },
                );
              }
              if (state is ProductListStateLoadingFailure) {
                return LoadingErrorWidget(onPressed: () {
                  _productListBloc.add(LoadProductList());
                });
              }
              return const Center(child: CircularProgressIndicator());
            },
            bloc: _productListBloc,
          ),
      );
    }
  }