import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_bloc_event.dart';
import 'base_bloc_state.dart';

abstract class BaseBloc<Event extends BaseBlocEvent, State extends BaseBlocState, T> extends Bloc<Event, State> {
  BaseBloc(super.initialState);

  Future<void> loadItems({
    required Emitter<State> emit,
    required Future<List<T>> Function() loadItemsFunction,
    required State Function(List<T> items, bool hasMoreItems) loadedState,
    required State Function(Object exception) loadingFailureState,
  }) async {
    try {
      final items = await loadItemsFunction();
      emit(loadedState(items, items.isNotEmpty));
    } catch (e) {
      emit(loadingFailureState(e));
    }
  }
}
