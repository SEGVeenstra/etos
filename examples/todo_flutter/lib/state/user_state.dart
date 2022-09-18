import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final String name;

  const UserState({
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
      ];
}
