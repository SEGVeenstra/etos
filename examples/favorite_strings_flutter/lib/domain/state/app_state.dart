import 'package:favorite_strings_flutter/domain/entities/favoritable_string.dart';

class AppState {
  final List<FavoritableString> all;
  final List<FavoritableString> favorites;

  const AppState({
    this.all = const [
      FavoritableString(string: 'One'),
      FavoritableString(string: 'Two'),
      FavoritableString(string: 'Three'),
      FavoritableString(string: 'Four'),
      FavoritableString(string: 'Five'),
    ],
    this.favorites = const [],
  });

  AppState copyWith({
    List<FavoritableString>? all,
    List<FavoritableString>? favorites,
  }) =>
      AppState(
        all: all ?? this.all,
        favorites: favorites ?? this.favorites,
      );
}
