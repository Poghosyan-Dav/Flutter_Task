import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_state.dart';
import 'package:flutter_challenge_todo_app/models/todo.dart';
import 'package:flutter_challenge_todo_app/models/visibility_filter.dart';

import 'filtered_todos_event.dart';
import 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;

  late StreamSubscription todosSubscrition;
  FilteredTodosBloc({required this.todosBloc})
      : super(
          todosBloc.state is TodosLoadSuccess
              ? FilteredTodosLoadSuccess(
                  (todosBloc.state as TodosLoadSuccess).todos as List<Todo>,
                  VisibilityFilter.all)
              : FilteredTodosLoadInProgress(),
        ) {
    todosSubscrition = todosBloc.stream.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated(
                (todosBloc.state as TodosLoadSuccess).todos as List<Todo>))
            as List<Todo>;
      }
      on<FilterUpdated>(_onFilterated);
      on<TodosUpdated>(_onTodosUpdated);
    });
  }

  void _onFilterated(
      FilterUpdated event, Emitter<FilteredTodosState> emit) async {
    if (todosBloc.state is TodosLoadSuccess) {
      emit(FilteredTodosLoadSuccess(
          _todosToFilteredTodos(
            (todosBloc.state as TodosLoadSuccess).todos as List<Todo>,
            event.filter,
          ),
          event.filter));
    }
  }

  void _onTodosUpdated(TodosUpdated event, Emitter<FilteredTodosState> emit) {
    final visivilityFilter = state is FilteredTodosLoadSuccess
        ? (state as FilteredTodosLoadSuccess).activeFilter
        : VisibilityFilter.all;

    emit(FilteredTodosLoadSuccess(
        _todosToFilteredTodos(
            (todosBloc.state as TodosLoadSuccess).todos as List<Todo>,
            visivilityFilter),
        visivilityFilter));
  }

  List<Todo> _todosToFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubscrition.cancel();
    return super.close();
  }
}
