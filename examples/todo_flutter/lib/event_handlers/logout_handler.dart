import 'package:todo_flutter/events/logout_event.dart';
import 'package:todo_flutter/state/app_state.dart';

class LogoutHandler {
  AppState call(LogoutEvent event, AppState state) {
    return const AppState(
      userState: null,
      todosState: null,
    );
  }
}
