import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/base_page.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/abstract/bloc/list_bloc/base_list_bloc.dart';
import 'package:wts_test/abstract/bloc/list_bloc/base_list_bloc_event.dart';
import 'package:wts_test/widgets/loading_error.dart';

abstract class BaseListviewPage extends BasePage {
  const BaseListviewPage({
    super.key,
    super.title,
  });
}

abstract class BaseListviewPageState<T extends BaseListviewPage,
    B extends BaseListBloc, D> extends BasePageState<T> {
  final bool shouldBeRefreshable = true;
  final bool shouldBeSeparated = false;
  final ScrollController scrollController = ScrollController();

  late final B listModel = createModel();

  /// Переопределить для создания модели
  B createModel();

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    listModel.add(const BaseBlockLoadEvent());
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
    listModel.add(const BaseBlockLoadMoreEvent());
  }

  int get itemCount => listModel.items.length;

  @override
  Widget buildBody(BuildContext context) {
    final listViewBody = _buildListView(context);
    if (shouldBeRefreshable) {
      return RefreshIndicator(
        child: listViewBody,
        onRefresh: handleRefresh,
      );
    }
    return listViewBody;
  }

  Widget _buildListView(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => listModel,
      child: BlocBuilder<B, BlocState>(
        bloc: listModel,
        builder: (context, state) {
          if (state is ErrorState) {
            return LoadingErrorWidget(
              onPressed: () => listModel.add(const ListReloadEvent()),
            );
          }
          if (state is DataFoundState<List<D>>) {
            return buildListViewBody(context);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
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
            if (!listModel.isAllLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox.shrink();
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
          if (!listModel.isAllLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        }
        return buildListItem(context, index);
      },
    );
  }

  @protected
  Widget buildListItem(BuildContext context, int index);

  @protected
  Future<void> handleRefresh() {
    final completer = Completer();
    listModel.add(ListReloadEvent(completer: completer));
    return completer.future;
  }

  @protected
  Widget buildSeparator(BuildContext context, int index) {
    return const SizedBox(height: 16);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    listModel.close();
    super.dispose();
  }
}
