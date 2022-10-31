import 'package:equatable/equatable.dart';
import 'package:todo_flutter/model/todo.dart';

class TodosState extends Equatable {
  final List<Todo> todos;
  final Todo? selectedTodo;

  const TodosState({
    required this.todos,
    this.selectedTodo,
  });

  TodosState copyWith(
          {List<Todo>? todos, Todo? selectedTodo, bool clearTodo = false}) =>
      TodosState(
        todos: todos ?? this.todos,
        selectedTodo: clearTodo ? null : selectedTodo ?? this.selectedTodo,
      );

  @override
  List<Object?> get props => [
        todos,
        selectedTodo,
      ];
}
