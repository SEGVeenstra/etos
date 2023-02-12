import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/login_event.dart';

import '../state/app_state.dart';

class LoginHandler extends EventHandler<AppState, LoginEvent> {
  @override
  void call(LoginEvent event) async {
    var currentState = getState();

    // We first check if we are in an unauthenticated state
    if (currentState is! UnauthenticatedAppState) return;

    // set state to loading
    setState(currentState.copyWith(isLoggingIn: true));

    // Fake login
    await Future.delayed(const Duration(seconds: 1));

    // We've passed an sync gap.
    // This means there is a possibility that the state has changed in the
    // meantime. So before we continue, we have to get hold of the current
    // state.
    currentState = getState();

    // Check if we are still logging in, if not, login has been canceled
    // and we can abort.
    if (currentState is! UnauthenticatedAppState ||
        currentState.isLoggingIn == false) return;

    // Everything is okay, we will set the loggedin state
    final newState = AuthenticatedState(
      userName: event.username,
      todos: const [],
      isLoadingTodos: false,
      selectedTodo: null,
    );

    setState(newState);
  }
}
