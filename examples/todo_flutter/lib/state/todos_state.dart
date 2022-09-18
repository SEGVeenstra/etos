import 'package:equatable/equatable.dart';
import 'package:todo_flutter/model/todo.dart';

class TodosState extends Equatable {
  final List<Todo> todos;

  const TodosState({required this.todos});

  TodosState copyWith({List<Todo>? todos}) =>
      TodosState(todos: todos ?? this.todos);

  @override
  List<Object?> get props => [
        todos,
      ];
}
