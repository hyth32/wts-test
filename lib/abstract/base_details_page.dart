import 'package:flutter/material.dart';
import 'package:wts_test/abstract/base_page.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_builder.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

abstract class BaseDetailsPage extends BasePage {
  const BaseDetailsPage({
    super.key,
    super.title,
  });
}

abstract class BaseDetailsPageState<T extends BaseDetailsPage,
    B extends BaseBloc> extends BasePageState<T> {
  late final B listModel = createModel();

  @override
  void initState() {
    listModel.add(BaseBlockLoadEvent());
    super.initState();
  }

  B createModel();

  @override
  Widget buildBody(BuildContext context) {
    final body = buildBlocBuilder(context);
    return body;
  }

  @protected
  Widget buildBlocBuilder(BuildContext context) {
    return BaseBlocBuilder<B, Product?>(
      buildContent: buildItem,
      bloc: listModel,
      onLoadingFailurePressed: () => listModel.add(BaseBlockLoadEvent()),
    );
  }

  @protected
  Widget buildItem(BuildContext context, DataFoundState<Product?> state);
}
