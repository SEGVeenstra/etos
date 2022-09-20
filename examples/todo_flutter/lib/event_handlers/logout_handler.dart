import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/logout_event.dart';
import 'package:todo_flutter/state/app_state.dart';
import 'package:todo_flutter/state/user_state.dart';

class LogoutHandler {
  void call(LogoutEvent event, _, StateSetter<AppState> set) {
    set(AppState(
      userState: LoggedOut(),
      todosState: null,
    ));
  }
}
