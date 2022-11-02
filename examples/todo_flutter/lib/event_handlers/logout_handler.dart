import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/logout_event.dart';
import 'package:todo_flutter/state/app_state.dart';

class LogoutHandler {
  void call(LogoutEvent event, _, StateSetter<AppState> set) {
    set(UnauthenticatedAppState());
  }
}
