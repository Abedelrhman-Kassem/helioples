import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/Icons_logos/Helioplis_logo.png",
      width: 95.w,
      height: 95.h,
    );
  }
}
