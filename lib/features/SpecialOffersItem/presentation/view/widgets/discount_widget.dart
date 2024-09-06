import 'package:flutter/material.dart';

Widget discountWidget({
  required String discount,
  required TextStyle textStyle,
  required Color color,
  required double alignBottom,
}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Text(
        discount,
        style: textStyle,
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: alignBottom,
        child: Container(
          height: 1,
          color: color,
        ),
      ),
    ],
  );
}
