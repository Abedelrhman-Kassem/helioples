import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class SettingsItem extends StatelessWidget {
  final String leadingIconPath;
  final String title;
  final String trailingIconPath;
  final VoidCallback onTap;

  const SettingsItem({
    Key? key,
    required this.leadingIconPath,
    required this.title,
    required this.trailingIconPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 5.w,
          end: 10.w,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              leadingIconPath,
            ),
            SizedBox(
              width: 25.w,
            ),
            Text(
              title,
              style: Styles.styles16w400Black,
            ),
            const Spacer(),
            SvgPicture.asset(
              trailingIconPath,
              height: 15.h,
              width: 15.w,
            ),
          ],
        ),
      ),
    );
  }
}
