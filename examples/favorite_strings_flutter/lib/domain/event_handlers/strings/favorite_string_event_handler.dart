import 'dart:async';

import 'package:etos_flutter/etos_flutter.dart';
import 'package:favorite_strings_flutter/domain/entities/favoritable_string.dart';
import 'package:favorite_strings_flutter/domain/events/strings/favorite_string_event.dart';
import 'package:favorite_strings_flutter/domain/helpers/favoritable_string_list_helpers.dart';
import 'package:favorite_strings_flutter/domain/state/app_state.dart';

class FavoriteStringEventHandler
    extends EventHandler<AppState, FavoriteStringEvent> {
  @override
  FutureOr<void> call(FavoriteStringEvent event) async {
    final currentState = getState();

    final currentFavorites = currentState.favorites;
    final currentAll = currentState.all;

    final newValue = FavoritableString(string: event.string, isFavorite: true);

    final newAll = [...currentAll].replaceString(newValue);
    final newFavorites = [...currentFavorites, newValue];

    setState(currentState.copyWith(
      all: newAll,
      favorites: newFavorites,
    ));
  }
}
