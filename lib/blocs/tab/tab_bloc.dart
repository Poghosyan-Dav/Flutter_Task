import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/tab/tab_event.dart';
import 'package:flutter_challenge_todo_app/models/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos) {
    on<TabUpdated>(_tabUpdated);
  }

  void _tabUpdated(TabUpdated event, Emitter<AppTab> emit) {
    emit(event.tab);
  }
}
