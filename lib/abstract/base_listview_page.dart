import 'package:flutter/material.dart';
import 'package:wts_test/abstract/base_page.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';

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

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    // TODO: Базовый event на загрузку данных блока
    // listModel.add(LoadProductList());
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

  void loadMore();

  @override
  Widget buildBody(BuildContext context) {
    final listViewBody = buildListViewBody(context);
    if (shouldBeRefreshable) {
      return RefreshIndicator(
        child: listViewBody,
        onRefresh: handleRefresh,
      );
    }
    return listViewBody;
  }

  @protected
  Widget buildListViewBody(BuildContext context) {
    if (shouldBeSeparated) {
      return ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        separatorBuilder: buildSeparator,
        itemCount: itemCount + 1,
        itemBuilder: (context, index) {
          if (index >= itemCount) {
            return const Center(child: CircularProgressIndicator());
          }
          return buildListItem(context, index);
        },
      );
    }
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: itemCount + 1,
      itemBuilder: (context, index) {
        if (index >= itemCount) {
          return const Center(child: CircularProgressIndicator());
        }
        return buildListItem(context, index);
      },
    );
  }

  @protected
  Widget buildListItem(BuildContext context, int index);

  @protected
  Future<void> handleRefresh();

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
