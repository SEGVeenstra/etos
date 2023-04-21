import 'dart:async';

import 'package:etos_flutter/etos_flutter.dart';
import 'package:favorite_strings_flutter/domain/entities/favoritable_string.dart';
import 'package:favorite_strings_flutter/domain/helpers/favoritable_string_list_helpers.dart';
import 'package:favorite_strings_flutter/domain/state/app_state.dart';

import '../../../data/repositories/favoritable_strings_repository.dart';
import '../../events/strings/unfavorite_string_event.dart';

class UnfavoriteStringEventHandler
    extends EventHandler<AppState, UnfavoriteStringEvent> {
  UnfavoriteStringEventHandler(this._repository);

  final FavoritableStringsRepository _repository;

  @override
  FutureOr<void> call(UnfavoriteStringEvent event) async {
    final currentState = getState();

    final currentFavorites = currentState.favorites;
    final currentAll = currentState.all;

    final newValue = FavoritableString(string: event.string, isFavorite: false);

    // Error handling is skipped so we asume this always is succesful
    await _repository.update(event.string, true);

    final newAll = [...currentAll].replaceString(newValue);
    final newFavorites = [...currentFavorites].removeString(event.string);

    setState(currentState.copyWith(
      all: newAll,
      favorites: newFavorites,
    ));
  }
}
