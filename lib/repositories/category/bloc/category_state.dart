part of 'category_bloc.dart';

class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryListLoading extends CategoryState {}

class CategoryListLoaded extends CategoryState {
  CategoryListLoaded({required this.categoryList});

  final List<Category> categoryList;
}

class CategoryListLoadingFailure extends CategoryState {
  CategoryListLoadingFailure({this.exception});

  final Object? exception;
}
