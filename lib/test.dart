import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 3) {
      // Store the current index
      int previousIndex = _selectedIndex;

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => AnotherScreen()),
      // ).then((_) {
      //   // Reset the selected index to the previous index when returning
      //   setState(() {
      //     _selectedIndex = previousIndex;
      //   });
      // });
    } else {
      // Update the selected index
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Selected Index: $_selectedIndex'),
      ),
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
        tabs: [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.search, text: 'Search'),
          GButton(icon: Icons.notifications, text: 'Notifications'),
          GButton(icon: Icons.person, text: 'Profile'),
        ],
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
