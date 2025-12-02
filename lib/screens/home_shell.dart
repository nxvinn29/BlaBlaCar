import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'your_rides_screen.dart';
import 'inbox_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const SearchScreen(),
    const YourRidesScreen(),
    const InboxScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      const BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Your rides'),
      const BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: 'Inbox'),
      const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
    ];

    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF00AEEF),
        unselectedItemColor: Colors.grey.shade600,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
