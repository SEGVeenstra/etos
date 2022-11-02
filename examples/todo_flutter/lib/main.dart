import 'package:etos_flutter/etos_flutter.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_flutter/event_handlers/add_todo_event_handler.dart';
import 'package:todo_flutter/event_handlers/login_handler.dart';
import 'package:todo_flutter/event_handlers/logout_handler.dart';
import 'package:todo_flutter/event_handlers/unselect_todo_event_handler.dart';
import 'package:todo_flutter/events/add_todo_event.dart';
import 'package:todo_flutter/events/login_event.dart';
import 'package:todo_flutter/events/logout_event.dart';
import 'package:todo_flutter/events/select_todo_event.dart';
import 'package:todo_flutter/pages/login_page.dart';
import 'package:todo_flutter/pages/todo_detail_page.dart';
import 'package:todo_flutter/pages/todos_page.dart';
import 'package:todo_flutter/state/app_state.dart';

import 'event_handlers/select_todo_event_handler.dart';
import 'events/unselect_todo_event.dart';

final etos = Etos<AppState>(
  state: UnauthenticatedAppState(),
)
  ..on<LoginEvent>(LoginHandler())
  ..on<LogoutEvent>(LogoutHandler())
  ..on<AddTodoEvent>(AddTodoEventHandler())
  ..on<SelectTodoEvent>(SelectTodoEventHandler())
  ..on<UnselectTodoEvent>(UnselectTodoEventHandler());

void main() {
  Logger.root.onRecord.listen((event) {
    debugPrint(event.toString());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EtosProvider<AppState>(
      etos: etos,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StateBuilder<AppState, AppState>(
          converter: (state) => state,
          builder: (context, state) {
            final isLoggedIn = state is AuthenticatedState;

            return Navigator(
              pages: [
                if (isLoggedIn)
                  const MaterialPage(child: TodosPage())
                else
                  const MaterialPage(child: LoginPage()),
                if (isLoggedIn && (state).selectedTodo != null)
                  const MaterialPage(child: TodoDetailPage())
              ],
              onPopPage: (route, result) {
                return false;
              },
            );
          },
        ),
      ),
    );
  }
}
