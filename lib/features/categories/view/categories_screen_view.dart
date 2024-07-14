import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/features/categories/widgets/category_tile.dart';
import 'package:wts_test/features/products_list/view/products_list_screen.dart';
import 'package:wts_test/repositories/category/abstract_category_repository.dart';
import 'package:wts_test/repositories/category/bloc/category_bloc.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';
import 'package:wts_test/widgets/loading_error.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _categoryBloc = CategoryBloc(GetIt.instance<AbstractCategoryRepository>());

  @override
  void initState() {
    _categoryBloc.add(LoadCategoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Категории',
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
            _categoryBloc.add(LoadCategoryList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryListLoaded) {
                return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 2.25,
                    ),
                    itemCount: state.categoryList.length,
                    itemBuilder: (context, index) {
                      Category category = state.categoryList[index];
                      return CategoryTile(
                          category: category,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProductListScreen(
                                  category: category,
                                )),
                            );
                          });
                    });
              }
              if (state is CategoryListLoadingFailure) {
                return LoadingErrorWidget(onPressed: () {
                  _categoryBloc.add(LoadCategoryList());
                });
              }
              return const Center(child: CircularProgressIndicator());
            },
            bloc: _categoryBloc,
          ),
        ));
  }
}
