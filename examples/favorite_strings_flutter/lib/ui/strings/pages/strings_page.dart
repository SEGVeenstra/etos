import 'package:etos_flutter/etos_flutter.dart';
import 'package:favorite_strings_flutter/domain/events/strings/favorite_string_event.dart';
import 'package:favorite_strings_flutter/domain/events/strings/on_unfavorite_string_event.dart';
import 'package:favorite_strings_flutter/domain/state/app_state.dart';
import 'package:favorite_strings_flutter/ui/strings/pages/favorite_strings_tab.dart';
import 'package:flutter/material.dart';

import 'all_strings_tab.dart';

class StringsPage extends StatefulWidget {
  const StringsPage({super.key});

  @override
  State<StringsPage> createState() => _StringsPageState();
}

class _StringsPageState extends State<StringsPage> {
  int _index = 0;

  void _updateIndex(int newIndex) {
    setState(() {
      _index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventListener<AppState>(
        listener: (context, event) {
          if (event is OnUnfavoriteStringEvent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You\'ve unfavorited "${event.string}"'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () =>
                      context.dispatch(FavoriteStringEvent(event.string)),
                ),
              ),
            );
          }
        },
        child: IndexedStack(
          index: _index,
          children: const [
            AllStringsTab(),
            FavoriteStringsTab(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _updateIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
