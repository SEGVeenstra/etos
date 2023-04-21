import 'package:etos_flutter/etos_flutter.dart';
import 'package:favorite_strings_flutter/data/data_sources/favoritable_strings_local_data_source.dart';
import 'package:favorite_strings_flutter/data/repositories/favoritable_strings_repository.dart';
import 'package:favorite_strings_flutter/domain/event_handlers/strings/favorite_string_event_handler.dart';
import 'package:favorite_strings_flutter/domain/event_handlers/strings/load_strings_event_handler.dart';
import 'package:favorite_strings_flutter/domain/events/strings/favorite_string_event.dart';
import 'package:favorite_strings_flutter/domain/events/strings/load_strings_event.dart';
import 'package:favorite_strings_flutter/domain/state/app_state.dart';
import 'package:favorite_strings_flutter/ui/favorite_strings_app.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'domain/event_handlers/strings/unfavorite_string_event_handler.dart';
import 'domain/events/strings/unfavorite_string_event.dart';

void main() {
  // Etos depends on the logging package for logging all events and states
  //
  // This way you can exactly see which event resulted in which state!
  Logger.root.onRecord.listen(
      (log) => debugPrint('[${log.level}] ${log.loggerName}: ${log.message}'));

  final etos = Etos(state: const AppState());

  final dataSource = FavoritableStringsLocalDataSource();
  final repository = FavoritableStringsRepository(dataSource);

  etos.on<LoadStringsEvent>(LoadStringsEventHandler(repository));
  etos.on<FavoriteStringEvent>(FavoriteStringEventHandler(repository));
  etos.on<UnfavoriteStringEvent>(UnfavoriteStringEventHandler(repository));

  runApp(
    EtosProvider(
      etos: etos,
      child: const FavoriteStringsApp(),
    ),
  );

  // We do this to initially load the data.
  etos.dispatch(const LoadStringsEvent());
}
