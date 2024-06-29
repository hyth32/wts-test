import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/features/products_list/widgets/widgets.dart';
import 'package:wts_test/repositories/category/category.dart';
import 'package:wts_test/repositories/product/bloc/product_bloc.dart';
import 'package:wts_test/repositories/product/product.dart';
import 'package:wts_test/widgets/loading_error.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Category? category;
  late ProductBloc _productBloc;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is Category, 'Invalid arguments');
    category = args as Category;

    _productBloc =
        ProductBloc(GetIt.instance<AbstractProductRepository>(), category);
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
            _productBloc.add(LoadProductList());
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductStateLoaded) {
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
              if (state is ProductStateLoadingFailure) {
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
