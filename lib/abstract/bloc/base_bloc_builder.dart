import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/widgets/loading_error.dart';

class BaseBlocBuilder<B extends BlocBase<S>, S, LoadedState extends S> extends StatelessWidget {
  const BaseBlocBuilder({
    super.key,
    required this.bloc,
    required this.buildContent,
    required this.onLoadingFailurePressed,
  });

  final B bloc;
  final Widget Function(BuildContext context, LoadedState state) buildContent;
  final VoidCallback onLoadingFailurePressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      bloc: bloc,
      builder: (context, state) {
        if (state is BaseBlocLoadingFailureState) {
          return LoadingErrorWidget(onPressed: onLoadingFailurePressed);
        }
        if (state is LoadedState) {
          return buildContent(context, state);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
