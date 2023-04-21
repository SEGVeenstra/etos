import 'dart:async';

import 'package:etos_flutter/etos_flutter.dart';
import 'package:favorite_strings_flutter/data/repositories/favoritable_strings_repository.dart';
import 'package:favorite_strings_flutter/domain/events/strings/load_strings_event.dart';
import 'package:favorite_strings_flutter/domain/state/app_state.dart';

class LoadStringsEventHandler extends EventHandler<AppState, LoadStringsEvent> {
  LoadStringsEventHandler(this._repository);

  final FavoritableStringsRepository _repository;

  @override
  FutureOr<void> call(LoadStringsEvent event) async {
    final strings = await _repository.read();

    final all = strings;
    final favorites = strings.where((s) => s.isFavorite).toList();

    final newState = getState().copyWith(
      all: all,
      favorites: favorites,
    );

    setState(newState);
  }
}
