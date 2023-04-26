import 'dart:async';

import 'package:etos_flutter/etos_flutter.dart';
import 'package:favorite_strings_flutter/domain/entities/favoritable_string.dart';
import 'package:favorite_strings_flutter/domain/events/strings/favorite_string_event.dart';
import 'package:favorite_strings_flutter/domain/helpers/favoritable_string_list_helpers.dart';
import 'package:favorite_strings_flutter/domain/state/app_state.dart';

import '../../../data/repositories/favoritable_strings_repository.dart';

class FavoriteStringEventHandler
    extends EventHandler<AppState, FavoriteStringEvent> {
  FavoriteStringEventHandler(this._repository);

  final FavoritableStringsRepository _repository;

  @override
  FutureOr<void> call(FavoriteStringEvent event) async {
    final currentState = getState();

    final currentFavorites = currentState.favorites;
    final currentAll = currentState.all;

    final newValue = FavoritableString(string: event.string, isFavorite: true);

    // Error handling is skipped so we asume this always is succesful
    await _repository.update(event.string, true);

    // Because the call is always succesful we can update the state.
    final newAll = [...currentAll].replaceString(newValue);

    final List<FavoritableString> newFavorites;
    if (!currentFavorites.any((element) => element.string == event.string)) {
      newFavorites = [...currentFavorites, newValue];
    } else {
      newFavorites = currentFavorites;
    }

    setState(getState().copyWith(
      all: newAll,
      favorites: newFavorites,
    ));
  }
}
