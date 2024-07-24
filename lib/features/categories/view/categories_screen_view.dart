import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/abstract/base_refresh_scaffold.dart';
import 'package:wts_test/abstract/bloc/base_bloc_builder.dart';
import 'package:wts_test/features/categories/widgets/category_tile.dart';
import 'package:wts_test/features/products_list/view/products_list_screen.dart';
import 'package:wts_test/repositories/category/abstract_category_repository.dart';
import 'package:wts_test/repositories/category/bloc/category_bloc.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _categoryBloc = CategoryBloc(GetIt.I<AbstractCategoryRepository>());

  @override
  void initState() {
    _categoryBloc.add(LoadCategoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshScaffold(
      appBarTitle: 'Категории',
      onRefresh: () async {
        final completer = Completer();
        _categoryBloc.add(LoadCategoryList(completer: completer));
        return completer.future;
      },
      body: BaseBlocBuilder<CategoryBloc, List<Category>>(
        buildContent: (context, state) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.25,
            ),
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              Category category = state.data[index];
              return CategoryTile(
                category: category,
                // TODO: Абстракт класс с роутами
                onTap: () => Navigator.push(
                  context,
                  ProductRoutes.productList(category),
                ),
              );
            },
          );
        },
        onLoadingFailurePressed: () {
          _categoryBloc.add(LoadCategoryList());
        },
        bloc: _categoryBloc,
      ),
    );
  }
}

abstract class ProductRoutes {
  static MaterialPageRoute productList(Category category) => MaterialPageRoute(
        builder: (context) => ProductListScreen(
          category: category,
        ),
      );
}
