import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoggedIn extends UserState {
  final String name;

  LoggedIn({required this.name});

  @override
  List<Object?> get props => [name];
}

class LoggedOut extends UserState {}

class LoggingIn extends UserState {}
