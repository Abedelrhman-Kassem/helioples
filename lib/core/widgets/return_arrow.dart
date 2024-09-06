import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

Widget returnArrow({
  required BuildContext context,
  required Function() onTap,
}) {
  bool isRtl = Directionality.of(context) == TextDirection.rtl;

  return IconButton(
    onPressed: onTap,
    icon: svgIcon(
      path: isRtl
          ? 'assets/svg_icons/arrow-right-1.svg'
          : 'assets/svg_icons/arrow-left.svg',
      width: 29.w,
      height: 29.h,
      color: const Color.fromRGBO(41, 45, 50, 1),
    ),
  );
}
