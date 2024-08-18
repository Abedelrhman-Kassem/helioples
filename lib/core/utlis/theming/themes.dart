import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: HexColor('#007e8f'),
  textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 20.w)),
  scaffoldBackgroundColor: HexColor('#fbfeff'),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: HexColor('#007e8f'),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      // statusBarColor: Colors.white,
      // statusBarIconBrightness: Brightness.dark,
    ),
  ),
);
