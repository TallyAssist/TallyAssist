import 'package:flutter/material.dart';

BottomNavigationBar bottomNav() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.file_upload),
        title: SizedBox.shrink(),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.file_download),
        title: SizedBox.shrink(),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.filter_none),
        title: SizedBox.shrink(),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.update),
        title: SizedBox.shrink(),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.computer),
        title: SizedBox.shrink(),
      ),
    ],
    // currentIndex: _selectedIndex,
    // selectedItemColor: Colors.amber[800],
    // onTap: _onItemTapped,
  );
}
