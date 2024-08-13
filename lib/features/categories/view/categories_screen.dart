import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/abstract/base_gridview_builder.dart';
import 'package:wts_test/abstract/base_navigation_tile_widget.dart';
import 'package:wts_test/abstract/base_page.dart';
import 'package:wts_test/abstract/bloc/base_bloc_builder.dart';
import 'package:wts_test/features/categories/widgets/category_tile.dart';
import 'package:wts_test/features/products_list/view/products_list_screen.dart';
import 'package:wts_test/repositories/category/abstract_category_repository.dart';
import 'package:wts_test/repositories/category/bloc/category_bloc.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';

class CategoriesScreen extends BasePage {
  const CategoriesScreen({super.key}) : super(title: 'Категории');

  @override
  State<StatefulWidget> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends BasePageState<CategoriesScreen> {
  final _categoryBloc = CategoryBloc(GetIt.I<AbstractCategoryRepository>());

  @override
  void initState() {
    _categoryBloc.add(LoadCategoryList());
    super.initState();
  }

  @override
  Widget buildBody(BuildContext context) {
    return BaseBlocBuilder<CategoryBloc, List<Category>>(
      buildContent: (context, state) {
        return BaseGridviewBuilder(
          itemCount: state.data.length,
          buildContent: (context, index) {
            final category = state.data[index];
            return BaseNavigationTileWidget(
              pageToNavigate: ProductListScreen(category: category),
              child: CategoryTile(category: category),
            );
          },
        );
      },
      onLoadingFailurePressed: () => _categoryBloc.add(LoadCategoryList()),
      bloc: _categoryBloc,
    );
  }
}
