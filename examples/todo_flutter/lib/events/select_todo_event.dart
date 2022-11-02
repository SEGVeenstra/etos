import 'package:todo_flutter/model/todo.dart';

class SelectTodoEvent {
  final int? id;
  final Todo? todo;

  const SelectTodoEvent._(this.id, this.todo);

  const SelectTodoEvent.id({this.id}) : todo = null;
  const SelectTodoEvent.todo({this.todo}) : id = null;
}
