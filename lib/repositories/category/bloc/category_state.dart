part of 'category_bloc.dart';

class CategoryState extends BaseBlocState {}

class CategoryInitial extends CategoryState {}

class CategoryListLoading extends BaseBlocLoadingState implements CategoryState {}

class CategoryListLoaded extends BaseBlocLoadedState<Category> implements CategoryState {
  CategoryListLoaded(super.categoryList);

  List<Category> get categoryList => itemList;
}

class CategoryListLoadingFailure extends BaseBlocLoadingFailureState implements CategoryState {
  CategoryListLoadingFailure({super.exception});
}