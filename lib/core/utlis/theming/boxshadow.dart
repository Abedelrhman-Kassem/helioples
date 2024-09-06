import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBoxShadows {
  static BoxShadow gNavBoxSahdow = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.15),
    spreadRadius: 0,
    blurRadius: 30.r,
    offset: Offset(0, -3.h),
  );

  static BoxShadow locationBoxShadow = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.2),
    spreadRadius: 0,
    blurRadius: 30.r,
    offset: Offset(0, 4.h),
  );

  static BoxShadow iconsIsCategoryBoxShadow = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.15),
    spreadRadius: 0,
    blurRadius: 10.r,
    offset: Offset(0, 4.h),
  );

  static BoxShadow checkOutBoxShadow = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.25),
    spreadRadius: 0,
    blurRadius: 33.55.r,
    offset: Offset(0, 8.95.h),
  );

  static BoxShadow cartCardBoxShadow = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.12),
    spreadRadius: 0,
    blurRadius: 14.r,
    offset: const Offset(0, 0),
  );
}
