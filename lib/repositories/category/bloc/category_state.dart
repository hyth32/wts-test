part of 'category_bloc.dart';

class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryListLoaded extends CategoryState {
  CategoryListLoaded({required this.categoryList});

  final List<Category> categoryList;
}