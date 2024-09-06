import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _selectedIndex = 0;
  int _previousIndex = 0;

  void _onTabChange(int index) {
    print("Tab clicked: $index");
    print("Current selected index: $_selectedIndex");
    print("Previous index: $_previousIndex");

    if (index == 1) {
      // Disabled tab logic
      print("Disabled tab clicked, reverting to previous index.");
      _onTabChange(0);
    } else {
      setState(() {
        // Update previous index before changing to the new one
        _previousIndex = _selectedIndex;
        _selectedIndex = index;
      });
    }

    // Ensure the UI updates correctly
    print("Updated selected index: $_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Selected index: $_selectedIndex'),
      ),
      bottomNavigationBar: GNav(
        gap: 8,
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
        tabs: [
          GButton(icon: Icons.home, text: _selectedIndex == 0 ? 'Home' : ''),
          GButton(icon: Icons.favorite, text: ''), // Disabled Tab
          GButton(
              icon: Icons.search, text: _selectedIndex == 2 ? 'Search' : ''),
          GButton(
              icon: Icons.person, text: _selectedIndex == 3 ? 'Profile' : ''),
        ],
      ),
    );
  }
}
