import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/add_todo_event.dart';

import '../state/app_state.dart';

class AddTodoEventHandler extends EventHandler<AppState, AddTodoEvent> {
  @override
  void call(AddTodoEvent event, StateGetter<AppState> getState,
      StateSetter<AppState> setState) {
    final currentState = getState();

    // We can only add todos if we are authenticated, so let's check that first.
    // If we're not authenticated, just stop.
    if (currentState is! AuthenticatedState) return;

    // We now create a new state by adding a new list with the old todos plus
    // the new one.
    final newState =
        currentState.copyWith(todos: [...currentState.todos, event.todo]);

    setState(newState);
  }
}
