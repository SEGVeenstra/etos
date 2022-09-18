import 'package:todo_flutter/events/login_event.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/state/app_state.dart';
import 'package:todo_flutter/state/todos_state.dart';
import 'package:todo_flutter/state/user_state.dart';

class LoginHandler {
  Future<AppState> call(LoginEvent event, AppState state) async {
    if (state.userState != null) throw 'already logged in';

    return state.copyWith(
      userState: UserState(
        name: event.username,
      ),
      todosState: const TodosState(todos: [
        Todo(description: 'Example', isDone: false),
      ]),
    );
  }
}
