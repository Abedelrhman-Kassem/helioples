import 'package:flutter/material.dart';

Widget overlay(bool isRtl) {
  return Positioned.fill(
    child: FractionallySizedBox(
      widthFactor: 0.7,
      alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color.fromRGBO(0, 0, 0, 1),
              Color.fromRGBO(0, 0, 0, 0),
            ],
            begin: isRtl ? Alignment.centerRight : Alignment.centerLeft,
            end: isRtl ? Alignment.centerLeft : Alignment.centerRight,
          ),
        ),
      ),
    ),
  );
}
