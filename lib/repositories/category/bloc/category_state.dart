part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitial extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryListLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryListLoaded extends CategoryState {
  CategoryListLoaded({required this.categoryList});

  final List<Category> categoryList;

  @override
  List<Object?> get props => [categoryList];
}

class CategoryListLoadingFailure extends CategoryState {
  CategoryListLoadingFailure({this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
