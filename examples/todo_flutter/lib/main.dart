import 'package:etos_flutter/etos_flutter.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/event_handlers/add_todo_event_handler.dart';
import 'package:todo_flutter/event_handlers/login_handler.dart';
import 'package:todo_flutter/event_handlers/logout_handler.dart';
import 'package:todo_flutter/events/add_todo_event.dart';
import 'package:todo_flutter/events/login_event.dart';
import 'package:todo_flutter/events/logout_event.dart';
import 'package:todo_flutter/pages/login_page.dart';
import 'package:todo_flutter/pages/todos_page.dart';
import 'package:todo_flutter/state/app_state.dart';

final etos = Etos(
  state: const AppState(
    userState: null,
    todosState: null,
  ),
)
  ..on<LoginEvent>(LoginHandler())
  ..on<LogoutEvent>(LogoutHandler())
  ..on<AddTodoEvent>(AddTodoEventHandler());

void main() {
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
        home: EtosBuilder(
          etos: etos,
          builder: (context, state) =>
              state.userState == null ? const LoginPage() : const TodosPage(),
        ),
      ),
    );
  }
}
