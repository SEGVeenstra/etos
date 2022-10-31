import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/login_event.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/state/todos_state.dart';
import 'package:todo_flutter/state/user_state.dart';

import '../state/app_state.dart';

class LoginHandler {
  void call(LoginEvent event, StateGetter<AppState> get,
      StateSetter<AppState> set) async {
    if (get().userState is LoggedIn) throw 'already logged in';

    // set loading
    set(get().copyWith(userState: LoggingIn()));

    // Fake login
    await Future.delayed(const Duration(seconds: 1));

    // Check if we are still logging in, if not, login has been canceled.
    if (get().userState is! LoggingIn) return;

    final newState = get().copyWith(
      userState: LoggedIn(
        name: event.username,
      ),
      todosState: const TodosState(todos: [
        Todo(
          title: 'Test',
          description: 'Example',
          isDone: false,
        ),
      ]),
    );

    set(newState);
  }
}
