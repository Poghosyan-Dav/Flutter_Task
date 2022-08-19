import 'package:equatable/equatable.dart';
import 'package:flutter_challenge_todo_app/models/app_tab.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
  @override
  List<Object> get props => [];
}

class TabUpdated extends TabEvent {
  final AppTab tab;
  const TabUpdated(this.tab);
  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
