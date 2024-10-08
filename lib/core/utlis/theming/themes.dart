import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: MyColors.mainColor,
  scaffoldBackgroundColor: MyColors.mainScaffoldWhiteColor,
  appBarTheme: AppBarTheme(
    toolbarHeight: 67.h,
    elevation: 20,
    backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
    centerTitle: true,
    titleTextStyle: Styles.styles17w700Black,
    shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: const SystemUiOverlayStyle(
      // Android
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      // IOS
      statusBarBrightness: Brightness.dark,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: MyColors.mainColor,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    toolbarHeight: 67.h,
    systemOverlayStyle: const SystemUiOverlayStyle(
      // Android
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.black,
      // IOS
      statusBarBrightness: Brightness.dark,
    ),
  ),
);
