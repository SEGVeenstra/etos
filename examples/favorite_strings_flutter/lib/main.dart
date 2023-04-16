import 'package:etos_flutter/etos_flutter.dart';
import 'package:favorite_strings_flutter/domain/event_handlers/strings/favorite_string_event_handler.dart';
import 'package:favorite_strings_flutter/domain/events/strings/favorite_string_event.dart';
import 'package:favorite_strings_flutter/domain/state/app_state.dart';
import 'package:favorite_strings_flutter/ui/favorite_strings_app.dart';
import 'package:flutter/material.dart';

import 'domain/event_handlers/strings/unfavorite_string_event_handler.dart';
import 'domain/events/strings/unfavorite_string_event.dart';

void main() {
  final etos = Etos(state: const AppState());

  etos.on<FavoriteStringEvent>(FavoriteStringEventHandler());
  etos.on<UnfavoriteStringEvent>(UnfavoriteStringEventHandler());

  runApp(
    EtosProvider(
      etos: etos,
      child: const FavoriteStringsApp(),
    ),
  );
}
