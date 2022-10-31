import 'package:flutter/material.dart';
import 'package:todo_flutter/events/unselect_todo_event.dart';
import 'package:todo_flutter/main.dart';

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('detail page'),
        leading: BackButton(
          onPressed: () => etos.dispatch(UnselectTodoEvent()),
        ),
      ),
      body: const Center(
        child: Text('Detail page'),
      ),
    );
  }
}
