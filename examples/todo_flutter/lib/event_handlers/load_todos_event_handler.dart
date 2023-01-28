import 'dart:async';

import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/load_todos_event.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/state/app_state.dart';

class LoadTodosEventHandler extends EventHandler<AppState, LoadTodosEvent> {
  @override
  FutureOr<void> call(
    LoadTodosEvent event,
    StateGetter<AppState> getState,
    StateSetter<AppState> setState,
  ) async {
    // get the current state
    final currentState = getState();
    if (currentState is! AuthenticatedState) return;

    setState(currentState.copyWith(isLoadingTodos: true));

    await Future.delayed(const Duration(seconds: 1));

    setState(
      currentState.copyWith(
        isLoadingTodos: false,
        todos: [
          const Todo(
            id: 1,
            title: 'initial todo',
            description: 'description',
            isDone: false,
          ),
        ],
      ),
    );
  }
}
