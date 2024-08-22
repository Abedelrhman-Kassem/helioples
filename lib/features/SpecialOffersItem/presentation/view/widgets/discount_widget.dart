import 'package:flutter/material.dart';

Widget discountWidget(String discount) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Text(
        discount,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(204, 42, 40, 1),
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 5, // Adjust this to control the vertical position of the line
        child: Container(
          height: 1,
          color: const Color.fromRGBO(204, 42, 40, 1),
        ),
      ),
    ],
  );
}
