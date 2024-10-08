import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/api/entities/api_response.dart';

abstract class BaseListviewBloc<T>
    extends BaseBloc<BaseBlocEvent, BlocState, List<T>> {
  BaseListviewBloc(super.initialState) {
    on<BaseBlockLoadEvent>(_onLoadList);
  }

  List<T> loadedData = [];
  bool isAllLoaded = false;

  int get offset => loadedData.length;

  @protected
  Future<void> _onLoadList(
    BaseBlockLoadEvent event,
    Emitter<BlocState> emit,
  ) async {
    if (isLoading || isAllLoaded) return;
    isLoading = true;

    final response = await fetchData();

    if (response.isError) {
      isAllLoaded = true;
      emit(ErrorState(message: response.error!));
      return;
    }
    loadedData.addAll(response.data!);
    isAllLoaded = response.data!.isEmpty;
    isLoading = false;
    emit(DataFoundState(data: loadedData));
    event.completer?.complete();
  }

  Future<ApiResponse<List<T>>> fetchData();
}
