import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/features/products_list/widgets/widgets.dart';
import 'package:wts_test/repositories/category/category.dart';
import 'package:wts_test/repositories/product_list/bloc/product_list_bloc.dart';
import 'package:wts_test/repositories/product_list/product_list.dart';
import 'package:wts_test/widgets/widgets.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Category category;
  late ProductListBloc _productListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args is Category, 'Invalid arguments');
    category = args as Category;

    _productListBloc = ProductListBloc(
      GetIt.instance<AbstractProductListRepository>(),
      category
    );
    _productListBloc.add(LoadProductList());
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[850],
            height: 1,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _productListBloc.add(LoadProductList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListStateLoaded) {
              return ListView.separated(
                controller: _scrollController,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
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
                      Navigator.of(context)
                          .pushNamed('/product', arguments: product);
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
      ),
    );
  }
}