import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBoxShadows {
  static BoxShadow gNavBoxSahdow = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.15),
    spreadRadius: 0,
    blurRadius: 30.r,
    offset: const Offset(0, -3),
  );

  static BoxShadow locationBoxShadow = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.2),
    spreadRadius: 0,
    blurRadius: 30.r,
    offset: const Offset(0, 4),
  );

  static BoxShadow iconsIsCategoryBoxShadow = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.15),
    spreadRadius: 0,
    blurRadius: 10.r,
    offset: const Offset(0, 4),
  );
}
