import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Notify listeners of the change.
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final Counter counter = Counter(); // Create the instance

  @override
  void initState() {
    super.initState();

    // Add a listener to rebuild the widget when state changes
    counter.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    counter.removeListener(() {}); // Clean up the listener
    counter.dispose(); // Dispose of the notifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Text('Count: ${counter.count}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
