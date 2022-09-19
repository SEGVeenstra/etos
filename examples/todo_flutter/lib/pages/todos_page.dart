import 'package:etos_flutter/etos_flutter.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/events/add_todo_event.dart';
import 'package:todo_flutter/events/logout_event.dart';
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
            onPressed: () => context.etos<AppState>().dispatch(LogoutEvent()),
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: EtosBuilder<AppState>(
        builder: (context, state) => ListView(
          children: state.todosState?.todos
                  .map((todo) => ListTile(
                        title: Text(todo.description),
                      ))
                  .toList() ??
              [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.etos<AppState>().dispatch(
              const AddTodoEvent(
                Todo(
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
