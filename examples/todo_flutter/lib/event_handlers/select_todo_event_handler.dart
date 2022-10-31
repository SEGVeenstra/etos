import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/state/app_state.dart';

import '../events/select_todo_event.dart';

class SelectTodoEventHandler extends EventHandler<AppState, SelectTodoEvent> {
  @override
  void call(SelectTodoEvent event, StateGetter<AppState> getState,
      StateSetter<AppState> setState) {
    setState(
      getState().copyWith(
        todosState: getState().todosState?.copyWith(
              selectedTodo: const Todo(
                title: 'title',
                description: 'description',
                isDone: false,
              ),
            ),
      ),
    );
  }
}
