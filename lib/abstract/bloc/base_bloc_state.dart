import 'package:equatable/equatable.dart';

abstract class BlocState extends Equatable {
  const BlocState();

  @override
  List<Object?> get props => [];
}

class InitialState<T> extends BlocState {
  final T? data;

  const InitialState([this.data]) : super();

  @override
  List<Object?> get props => [data];
}

class LoadingState extends BlocState {
  const LoadingState() : super();
}

class DataFoundState<T> extends BlocState {
  final T data;

  const DataFoundState({required this.data}) : super();

  @override
  List<Object?> get props => [data];
}

class ErrorState extends BlocState {
  final String message;

  const ErrorState({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
