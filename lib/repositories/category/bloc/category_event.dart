part of 'category_bloc.dart';

class CategoryEvent extends BaseBlocEvent {}

class LoadCategoryList extends BaseBlockLoadEvent implements CategoryEvent {
  LoadCategoryList({super.completer});
}
