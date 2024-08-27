import 'dart:async';

import 'package:equatable/equatable.dart';

class BaseBlocEvent extends Equatable {
  const BaseBlocEvent({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class BaseBlockLoadEvent extends BaseBlocEvent {
  const BaseBlockLoadEvent({super.completer});
}

class BaseBlockLoadMoreEvent extends BaseBlocEvent {
  const BaseBlockLoadMoreEvent({super.completer});
}
