import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/add_todo_event.dart';
import 'package:todo_flutter/model/todo.dart';

import '../state/app_state.dart';

class AddTodoEventHandler {
  void call(AddTodoEvent event, StateGetter<AppState> get,
      StateSetter<AppState> set) {
    final currentTodos = get().todosState?.todos ?? <Todo>[];
    final newState = get().copyWith(
      todosState: get().todosState?.copyWith(
        todos: [...currentTodos, event.todo],
      ),
    );
    set(newState);
  }
}
