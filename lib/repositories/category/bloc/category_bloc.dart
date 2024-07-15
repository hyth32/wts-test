import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/repositories/category/abstract_category_repository.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';

part 'category_state.dart';

part 'category_event.dart';

class CategoryBloc extends BaseBloc<CategoryEvent, CategoryState, Category> {
  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<LoadCategoryList>(_onLoadCategoryList);
  }

  Future<void> _onLoadCategoryList(
      LoadCategoryList event, Emitter<CategoryState> emit) async {
    await loadItems(
      emit: emit,
      loadItemsFunction: () async =>
          await categoryRepository.getCategoriesList(),
      loadedState: (items, _) => CategoryListLoaded(items),
      loadingFailureState: (exception) =>
          CategoryListLoadingFailure(exception: exception),
    );
    event.completer?.complete();
  }

  final AbstractCategoryRepository categoryRepository;
}
