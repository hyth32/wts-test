import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/widgets/loading_error.dart';

class BaseBlocBuilder<B extends BlocBase<BlocState>, Data>
    extends StatelessWidget {
  const BaseBlocBuilder({
    required this.bloc,
    required this.buildContent,
    required this.onLoadingFailurePressed,
    super.key,
  });

  final B bloc;
  final Widget Function(BuildContext context, DataFoundState<Data> state)
      buildContent;
  final VoidCallback onLoadingFailurePressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, BlocState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is ErrorState) {
          return LoadingErrorWidget(onPressed: onLoadingFailurePressed);
        }
        if (state is DataFoundState<Data>) {
          return buildContent(context, state);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
