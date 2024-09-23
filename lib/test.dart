import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Modal Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String? result = await showCustomModalBottomSheet(
              context,
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, 'hello');
                  },
                  child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 200,
                      child: Text('hello')),
                ),
              ),
            );
            print(result);
          },
          child: Text('Show Custom Modal'),
        ),
      ),
    );
  }

  Future<String>? showCustomModalBottomSheet(
      BuildContext context, Widget child) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows dismissing by tapping outside
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            child,
          ],
        );
      },
    );
    return null;
  }
}
