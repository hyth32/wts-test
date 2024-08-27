import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/abstract/bloc/list_bloc/base_list_bloc_event.dart';

abstract class BaseListBloc<State extends BlocState, T>
    extends Bloc<BaseBlocEvent, BlocState> {
  bool isLoading = false;
  bool isAllLoaded = false;
  bool _isFullReloading = false;

  final List<T> _items = [];

  List<T> get items => _items;

  int get offset => _isFullReloading ? 0 : _items.length;

  BaseListBloc() : super(const InitialState()) {
    on<BaseBlocEvent>(loadData);
    on<ListReloadEvent>(reloadData);
  }

  Future<void> loadNextItems(
    BaseBlocEvent event,
    Emitter<BlocState> emit,
  );

  Future<void> loadData(
    BaseBlocEvent event,
    Emitter<BlocState> emit,
  ) async {
    if (isAllLoaded || isLoading) {
      return;
    }
    isLoading = true;
    if (event is BaseBlockLoadEvent) {
      emit(const LoadingState());
    }
    await loadNextItems(event, emit);
  }

  Future<void> onNextItemsLoaded(
    List<T> nextItems,
    BaseBlocEvent event,
    Emitter<BlocState> emit,
  ) async {
    if (_isFullReloading) {
      clearData();
      _isFullReloading = false;
    }
    if (nextItems.isNotEmpty) {
      _items.addAll(nextItems);
    }
    isAllLoaded = checkAllLoaded(nextItems);
    isLoading = false;
    if (!(event.completer?.isCompleted ?? true)) {
      event.completer?.complete();
    }
    emit(DataFoundState(data: _items));
  }

  void onLoadingError(String? error, Emitter<BlocState> emit) {
    isAllLoaded = true;
    emit(ErrorState(message: error ?? "Unknown error occurred"));
  }

  bool checkAllLoaded(List<T> nextItems) {
    return nextItems.isEmpty;
  }

  void clearData() {
    items.clear();
  }

  void reset({
    bool soft = false,
  }) {
    isAllLoaded = false;
    _isFullReloading = true;
    isLoading = false;
    if (!soft) {
      clearData();
    }
  }

  FutureOr<void> reloadData(
    ListReloadEvent event,
    Emitter<BlocState> emit, {
    bool soft = true,
  }) async {
    if (isLoading) return;
    reset(soft: soft);
    await loadData(event, emit);
  }
}
