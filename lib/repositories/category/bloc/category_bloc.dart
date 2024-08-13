import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/repositories/category/abstract_category_repository.dart';

// part 'category_event.dart';

class CategoryBloc extends BaseBloc<BaseBlocEvent, BlocState, Category> {
  final AbstractCategoryRepository categoryRepository;

  CategoryBloc(
    this.categoryRepository,
  ) : super(const InitialState()) {
    on<BaseBlockLoadEvent>(_onLoadCategoryList);
  }

  Future<void> _onLoadCategoryList(
    BaseBlockLoadEvent event,
    Emitter<BlocState> emit,
  ) async {
    final response = await categoryRepository.getCategoriesList();
    if (response.isError) {
      emit(ErrorState(message: response.error!));
      return;
    }
    emit(DataFoundState(data: response.data!));
    event.completer?.complete();
  }
}
