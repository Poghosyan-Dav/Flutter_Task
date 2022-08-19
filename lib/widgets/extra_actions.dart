import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_event.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_state.dart';
import 'package:flutter_challenge_todo_app/flutter_todos_keys.dart';
import 'package:flutter_challenge_todo_app/models/extra_action.dart';

class ExtraActions extends StatelessWidget {
  const ExtraActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoadSuccess) {
          bool allComplete =
              (BlocProvider.of<TodosBloc>(context).state as TodosLoadSuccess)
                  .todos
                  .every((todo) => todo.complete);
          return PopupMenuButton<ExtraAction>(
            key: FlutterTodosKeys.extraActionsPopupMenuButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  BlocProvider.of<TodosBloc>(context).add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  BlocProvider.of<TodosBloc>(context).add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete ? 'mark all in  comleted' : 'marl all completed',
                ),
              ),
              const PopupMenuItem<ExtraAction>(
                value: ExtraAction.clearCompleted,
                child: Text('clear all'),
              ),
            ],
          );
        }
        return Container(key: FlutterTodosKeys.extraActionsEmptyContainer);
      },
    );
  }
}
