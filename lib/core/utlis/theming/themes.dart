import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFF007E8F),
  scaffoldBackgroundColor: const Color(0xFFFBFEFF),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xFF007E8F),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      // statusBarColor: Colors.white,
      // statusBarIconBrightness: Brightness.dark,
    ),
  ),
);
