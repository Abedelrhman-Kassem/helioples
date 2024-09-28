import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? result;

    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Modal Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            result = await showCustomModalBottomSheet(
              context,
              Material(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        30,
                        (index) => ListTile(
                          title: InkWell(
                              onTap: () {
                                Navigator.pop(context, 'Item ${index + 1}');
                              },
                              child: Text('Item ${index + 1}')),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
            print(result);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Show Custom Modal'),
              if (result is String) Text(result),
            ],
          ),
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
