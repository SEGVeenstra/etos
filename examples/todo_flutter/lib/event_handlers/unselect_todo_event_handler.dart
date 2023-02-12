import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/unselect_todo_event.dart';
import 'package:todo_flutter/state/app_state.dart';

class UnselectTodoEventHandler
    extends EventHandler<AppState, UnselectTodoEvent> {
  @override
  bool callWhen(AppState state) => state is AuthenticatedState;

  @override
  void call(UnselectTodoEvent event) {
    // We can force-cast the event because of the `callWhen` method.
    final currentState = getState() as AuthenticatedState;

    setState(currentState.clearSelectedTodo());
  }
}
