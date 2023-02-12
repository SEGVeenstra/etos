import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/state/app_state.dart';

import '../events/select_todo_event.dart';

class SelectTodoEventHandler extends EventHandler<AppState, SelectTodoEvent> {
  @override
  void call(SelectTodoEvent event) {
    final currentState = getState();

    // This can only be done by an authenticated user
    if (currentState is! AuthenticatedState) return;

    if (event.todo != null) {
      setState(currentState.copyWith(selectedTodo: event.todo));
    } else {
      // TODO use the passed 'id' to fetch the Todo
    }
  }
}
