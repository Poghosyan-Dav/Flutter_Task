import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/filtered_todos/filtered_todos_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/simple_bloc_observer.dart';
import 'package:flutter_challenge_todo_app/blocs/stats/stats_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/tab/tab_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_bloc.dart';
import 'package:flutter_challenge_todo_app/screens/home_screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const TodosApp());
}

class TodosApp extends StatelessWidget {
  const TodosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TabBloc>(
            create: (context) => TabBloc(),
          ),
          BlocProvider<FilteredTodosBloc>(
            create: (context) => FilteredTodosBloc(
              todosBloc: BlocProvider.of<TodosBloc>(context),
            ),
          ),
          BlocProvider<StatsBloc>(
            create: (context) => StatsBloc(
              todosBloc: BlocProvider.of<TodosBloc>(context),
            ),
          ),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
