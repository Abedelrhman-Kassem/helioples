import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  final String fromParent;
  const PageNotFoundScreen({super.key, required this.fromParent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      body: Center(child: Text(fromParent)),
    );
  }
}
