import 'package:equatable/equatable.dart';

import '../model/todo.dart';

abstract class AppState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UnauthenticatedAppState extends AppState {
  final bool isLoggingIn;

  UnauthenticatedAppState({this.isLoggingIn = false});

  @override
  List<Object?> get props => [...super.props, isLoggingIn];

  AppState copyWith({bool? isLoggingIn}) =>
      UnauthenticatedAppState(isLoggingIn: isLoggingIn ?? this.isLoggingIn);
}

class AuthenticatedState extends AppState {
  final String userName;
  final bool isLoadingTodos;
  final List<Todo> todos;
  final Todo? selectedTodo;

  AuthenticatedState({
    required this.userName,
    required this.todos,
    required this.isLoadingTodos,
    required this.selectedTodo,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        userName,
        isLoadingTodos,
        todos,
        selectedTodo,
      ];

  AppState copyWith({
    List<Todo>? todos,
    Todo? selectedTodo,
  }) =>
      AuthenticatedState(
        userName: userName,
        todos: todos ?? this.todos,
        isLoadingTodos: isLoadingTodos,
        selectedTodo: selectedTodo ?? this.selectedTodo,
      );

  AppState clearSelectedTodo() => AuthenticatedState(
        userName: userName,
        todos: todos,
        isLoadingTodos: isLoadingTodos,
        selectedTodo: null,
      );
}
