import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/features/categories/widgets/widgets.dart';
import 'package:wts_test/repositories/category/bloc/category_bloc.dart';
import 'package:wts_test/repositories/category/category.dart';
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
          title: const Text('Категории'),
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryListLoaded) {
              return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: state.categoryList.length,
                  itemBuilder: (context, index) {
                    Category category = state.categoryList[index];
                    return CategoryTile(
                        category: category,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/list', arguments: category);
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
        ));
  }
}
