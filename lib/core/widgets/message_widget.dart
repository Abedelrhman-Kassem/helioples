import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.imageName,
    required this.message,
  });
  final String imageName;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 150,
            child: Image(
              image: AssetImage('assets/images/$imageName'),
            ),
          ),
          const Gap(20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
