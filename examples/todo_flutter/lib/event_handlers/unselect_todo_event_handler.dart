import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/unselect_todo_event.dart';
import 'package:todo_flutter/state/app_state.dart';

class UnselectTodoEventHandler
    extends EventHandler<AppState, UnselectTodoEvent> {
  @override
  void call(UnselectTodoEvent event, StateGetter<AppState> getState,
      StateSetter<AppState> setState) {
    setState(
      getState().copyWith(
        todosState: getState().todosState?.copyWith(
              clearTodo: true,
            ),
      ),
    );
  }
}
