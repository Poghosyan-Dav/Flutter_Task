import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_challenge_todo_app/models/models.dart';
import '../blocs.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosBloc todosBloc;
  late StreamSubscription todosSubscription;
  StatsBloc({required this.todosBloc}) : super(StatsLoadInProgress()) {
    void onTodosStateChanged(state) {
      if (state is TodosLoadSuccess) {
        add(StatsUpdated(state.todos)) as List<Todo>;
      }
    }

    onTodosStateChanged(todosBloc.state);
    todosSubscription = todosBloc.stream.listen(onTodosStateChanged);

    on<StatsUpdated>(_statsUpdated);
  }

  void _statsUpdated(StatsUpdated event, Emitter<StatsState> emitter) {
    if (state is StatsUpdated) {
      final numActive =
          event.todos.where((todos) => !todos.complete).toList().length;
      final numCompleted =
          event.todos.where((todos) => todos.complete).toList().length;

      emitter(StatsLoadSuccess(numActive, numCompleted));
    }
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
