import 'package:etos_flutter/etos_flutter.dart';
import 'package:favorite_strings_flutter/domain/entities/favoritable_string.dart';
import 'package:favorite_strings_flutter/domain/events/strings/unfavorite_string_event.dart';
import 'package:favorite_strings_flutter/domain/state/app_state.dart';
import 'package:favorite_strings_flutter/ui/strings/widgets/string_list_item.dart';
import 'package:flutter/material.dart';

class FavoriteStringsTab extends StatelessWidget {
  const FavoriteStringsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StateBuilder<AppState, List<FavoritableString>>(
      converter: (state) => state.favorites,
      builder: (context, value) {
        if (value.isEmpty) {
          return const Center(child: Text('No favorites yet!'));
        }
        return ListView(
          children: value
              .map(
                (e) => StringListItem(
                  name: e.string,
                  isFavorite: e.isFavorite,
                  onTap: () =>
                      context.dispatch(UnfavoriteStringEvent(e.string)),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
