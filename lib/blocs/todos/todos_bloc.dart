import 'package:bloc/bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_event.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_state.dart';
import 'package:flutter_challenge_todo_app/models/todo.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoadInProgress()) {
    on<TodoAdded>(_onAdded);
    on<TodoUpdated>(_onUpdated);
    on<TodoDeleted>(_onDeleted);
    on<ToggleAll>(_onToglleAll);
    on<ClearCompleted>(_onClearCompleted);
  }

  void _onAdded(TodoAdded event, Emitter<TodosState> emit) {
    if (state is TodosLoadSuccess) {
      List<Todo> addedTodos = List.from((state as TodosLoadSuccess).todos)
        ..add(event.todo);
      emit(TodosLoadSuccess(addedTodos));
    }
  }

  void _onUpdated(TodoUpdated event, Emitter<TodosState> emit) {
    if (state is TodoUpdated) {
      List updateTodos = (state as TodosLoadSuccess)
          .todos
          .map((todo) => todo.id == event.todo.id ? event.todo : todo)
          .toList();

      emit(TodosLoadSuccess(updateTodos as List<Todo>));
    }
  }

  void _onDeleted(TodoDeleted event, Emitter<TodosState> emit) {
    if (state is TodosLoadSuccess) {
      final deletedTodos = (state as TodosLoadSuccess)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();

      emit(TodosLoadSuccess(deletedTodos));
    }
  }

  void _onToglleAll(ToggleAll event, Emitter<TodosState> emit) {
    if (state is TodosLoadSuccess) {
      final allComplete =
          (state as TodosLoadSuccess).todos.every((todo) => todo.complete);

      List togoAllTodos = (state as TodosLoadSuccess)
          .todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
    }
  }

  void _onClearCompleted(ClearCompleted event, Emitter<TodosState> emit) {
    if (state is TodosLoadSuccess) {
      final List updatedTodos = (state as TodosLoadSuccess)
          .todos
          .where((todo) => !todo.complete)
          .toList();
      emit(TodosLoadSuccess(updatedTodos as List<Todo>));
    }
  }
}
