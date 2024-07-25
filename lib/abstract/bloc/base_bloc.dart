import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_bloc_event.dart';
import 'base_bloc_state.dart';

// TODO: Сделать базовый блок для списков наследовать от [BaseBloc].
// Вынести дублирование работы с данными списков
abstract class BaseBloc<Event extends BaseBlocEvent, State extends BlocState, T>
    extends Bloc<Event, BlocState> {
  bool isLoading = false;

  BaseBloc(super.initialState);

  Future<void> loadData({
    required Emitter<State> emit,
    required Future<T> Function() loadItemsFunction,
    required State Function(T items) loadedState,
    required State Function(Object exception) loadingFailureState,
  }) async {
    try {
      final items = await loadItemsFunction();
      emit(loadedState(items));
    } catch (e) {
      emit(loadingFailureState(e));
    }
  }
}
