part of 'category_bloc.dart';

class CategoryEvent {}

class LoadCategoryList extends CategoryEvent {
  LoadCategoryList({this.completer});

  final Completer? completer;
}