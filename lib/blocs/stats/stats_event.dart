import 'package:equatable/equatable.dart';

import '../../models/todo.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
  @override
  List<Object> get props => [];
}

class StatsUpdated extends StatsEvent {
  final List<Todo> todos;
  const StatsUpdated(this.todos);
  @override
  List<Object> get props => [todos];
  @override
  String toString() => 'StatsUpdated { todos: $todos }';
}
