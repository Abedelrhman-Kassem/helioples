import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: MyColors.mainColor,
  textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 20.w)),
  scaffoldBackgroundColor: MyColors.mainScaffoldWhiteColor,
  appBarTheme: const AppBarTheme(
    elevation: 20,
    backgroundColor: Color.fromRGBO(250, 250, 250, 1),
    centerTitle: true,
    shadowColor: Color.fromRGBO(0, 0, 0, 0.2),
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      // Android
      statusBarColor: Color.fromRGBO(250, 250, 250, 1),
      statusBarIconBrightness: Brightness.dark,
      // IOS
      statusBarBrightness: Brightness.dark,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: MyColors.mainColor,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      // Android
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.black,
      // IOS
      statusBarBrightness: Brightness.dark,
    ),
  ),
);
