import 'package:todo_flutter/events/add_todo_event.dart';

import '../state/app_state.dart';

class AddTodoEventHandler {
  AppState call(AddTodoEvent event, AppState state) {
    final currentTodos = state.todosState?.todos ?? [];
    return state.copyWith(
      todosState: state.todosState?.copyWith(
        todos: [...currentTodos, event.todo],
      ),
    );
  }
}
