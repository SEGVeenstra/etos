import 'package:equatable/equatable.dart';
import 'package:todo_flutter/state/todos_state.dart';
import 'package:todo_flutter/state/user_state.dart';

class AppState extends Equatable {
  final UserState userState;
  final TodosState? todosState;

  const AppState({
    required this.userState,
    required this.todosState,
  });

  AppState copyWith({
    UserState? userState,
    TodosState? todosState,
  }) =>
      AppState(
        userState: userState ?? this.userState,
        todosState: todosState ?? this.todosState,
      );

  AppState copyWithNull({
    bool? todosState,
  }) =>
      AppState(
        userState: userState,
        todosState: todosState == true ? null : this.todosState,
      );

  @override
  List<Object?> get props => [
        userState,
        todosState,
      ];
}
