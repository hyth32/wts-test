import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class BaseBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class BaseBlockLoadEvent extends BaseBlocEvent {
  BaseBlockLoadEvent({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}