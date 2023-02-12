import 'package:etos_flutter/etos_flutter.dart';
import 'package:todo_flutter/events/logout_event.dart';
import 'package:todo_flutter/state/app_state.dart';

class LogoutHandler extends EventHandler<AppState, LogoutEvent> {
  @override
  void call(LogoutEvent event) {
    setState(UnauthenticatedAppState());
  }
}
