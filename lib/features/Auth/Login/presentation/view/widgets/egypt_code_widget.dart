import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';

class EgyptionCodeWidget extends StatelessWidget {
  const EgyptionCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.25 * MediaQuery.sizeOf(context).width,
      height: 0.07 * MediaQuery.sizeOf(context).height,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(239, 239, 239, 1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.black,
            width: 1, // Set the border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flag.fromCode(
                FlagsCode.EG,
                flagSize: FlagSize.size_4x3,
                height: 28,
                width: 28,
              ),
              const Text(
                "   +20",
                style: TextStyle(fontSize: 15, color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}
