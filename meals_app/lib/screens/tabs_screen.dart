import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screens.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'title': 'Deli Meals',
      'screen': CategoriesScreen()
    },
    {
      'title': 'Favorites',
      'screen': FavoritesScreen()
    }
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: _pages[_selectedPageIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).backgroundColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold
        ),
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ]
      ),
    );
  }
}