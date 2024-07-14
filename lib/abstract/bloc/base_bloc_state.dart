import 'package:equatable/equatable.dart';

abstract class BaseBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class BaseBlocLoadingState extends BaseBlocState {}

abstract class BaseBlocLoadedState<T> extends BaseBlocState {
  BaseBlocLoadedState(this.itemList);

  final List<T> itemList;

  @override
  List<Object?> get props => [itemList];
}

abstract class BaseBlocLoadingFailureState extends BaseBlocState {
  BaseBlocLoadingFailureState({this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
