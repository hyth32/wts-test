part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {}

class LoadCategoryList extends CategoryEvent {
  LoadCategoryList({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}