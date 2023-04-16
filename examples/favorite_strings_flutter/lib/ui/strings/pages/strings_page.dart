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
      body: IndexedStack(
        index: _index,
        children: const [
          AllStringsTab(),
          FavoriteStringsTab(),
        ],
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
