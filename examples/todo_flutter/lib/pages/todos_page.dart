import 'package:etos_flutter/etos_flutter.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/events/add_todo_event.dart';
import 'package:todo_flutter/events/logout_event.dart';
import 'package:todo_flutter/events/select_todo_event.dart';
import 'package:todo_flutter/helpers/object_ext.dart';
import 'package:todo_flutter/main.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/state/app_state.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
            key: const ValueKey('logout_button'),
            onPressed: () => etos.dispatch(LogoutEvent()),
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: StateBuilder<AppState, List<Todo>?>(
        converter: (state) => state.tryCast<AuthenticatedState>()?.todos,
        builder: (context, todos) => ListView(
          children: (todos ?? [])
              .map(
                (todo) => ListTile(
                  title: Text(todo.description),
                  onTap: () => etos.dispatch(SelectTodoEvent.todo(todo: todo)),
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => etos.dispatch(
          const AddTodoEvent(
            Todo(
              id: 1,
              title: 'test',
              description: 'test',
              isDone: false,
            ),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
