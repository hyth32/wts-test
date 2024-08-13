import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wts_test/abstract/base_page.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_builder.dart';
import 'package:wts_test/repositories/product_list/bloc/product_list_bloc.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

abstract class BaseListviewPage extends BasePage {
  const BaseListviewPage({
    super.key,
    super.title,
  });
}

abstract class BaseListviewPageState<T extends BaseListviewPage,
    B extends BaseBloc> extends BasePageState<T> {
  final bool shouldBeRefreshable = false;
  final bool shouldBeSeparated = false;
  final ScrollController scrollController = ScrollController();

  late final B listModel = createModel();

  /// Переопределить для создания модели
  B createModel();

  void initState() {
    scrollController.addListener(_onScroll);
    // TODO: Базовый event на загрузку данных блока
    listModel.add(LoadProductList());
    super.initState();
  }

  void _onScroll() {
    if (!mounted) return;
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    }
  }

  void loadMore() {
    listModel.add(LoadProductList());
  }

  @override
  Widget buildBody(BuildContext context) {
    final listViewBody = buildBlocBuilder(context);
    if (shouldBeRefreshable) {
      return RefreshIndicator(
        child: listViewBody,
        onRefresh: handleRefresh,
      );
    }
    return listViewBody;
  }

  @protected
  Widget buildBlocBuilder(BuildContext context) {
    return BaseBlocBuilder<B, List<Product>>(
      buildContent: (context, state) {
        return buildListViewBody(context);
      },
      bloc: listModel,
      onLoadingFailurePressed: () => listModel.add(LoadProductList()),
    );
  }

  @protected
  Widget buildListViewBody(BuildContext context) {
    if (shouldBeSeparated) {
      return ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        separatorBuilder: buildSeparator,
        itemCount: itemCount,
        itemBuilder: buildItems,
      );
    }
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: buildItems,
    );
  }

  @protected
  Widget buildListItem(BuildContext context, int index);

  @protected
  Widget buildItems(BuildContext context, int index) {
    if (index >= itemCount) {
      return const Center(child: CircularProgressIndicator());
    }
    return buildListItem(context, index);
  }

  Future<void> handleRefresh() {
    final completer = Completer();
    listModel.add(LoadProductList(completer: completer));
    return completer.future;
  }

  @protected
  Widget buildSeparator(BuildContext context, int index) {
    return const SizedBox(height: 16);
  }

  @protected
  int get itemCount;

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    listModel.close();
    super.dispose();
  }
}
