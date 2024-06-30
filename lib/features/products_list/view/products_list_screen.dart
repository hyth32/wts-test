import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/features/products_list/widgets/widgets.dart';
import 'package:wts_test/repositories/category/category.dart';
import 'package:wts_test/repositories/product_list/bloc/product_list_bloc.dart';
import 'package:wts_test/widgets/loading_error.dart';

import '../../../repositories/product_list/product_list.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Category? category;
  late ProductListBloc _productBloc;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is Category, 'Invalid arguments');
    category = args as Category;

    _productBloc =
        ProductListBloc(GetIt.instance<AbstractProductListRepository>(), category);
    _productBloc.add(LoadProductList());

    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${category?.title}'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _productBloc.add(LoadProductList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListStateLoaded) {
                return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    padding: const EdgeInsets.all(12),
                    itemCount: state.productList.length,
                    itemBuilder: (context, index) {
                      final item = state.productList[index];
                      return ProductTile(
                        item: item,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/product', arguments: item);
                        },
                      );
                    });
              }
              if (state is ProductListStateLoadingFailure) {
                return LoadingErrorWidget(onPressed: () {
                  _productBloc.add(LoadProductList());
                });
              }
              return const Center(child: CircularProgressIndicator());
            },
            bloc: _productBloc,
          ),
        ));
  }
}
