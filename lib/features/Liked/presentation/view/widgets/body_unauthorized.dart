import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

Widget bodyUnAuthorized(BuildContext context) {
  return Center(
    child: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, signInScreen);
      },
      child: Row(
        spacing: 10.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.liked_screen_You_must_login_first.tr(),
            style: TextStyle(color: MyColors.mainColor),
          ),
          Icon(
            Icons.login,
            color: MyColors.mainColor,
          ),
        ],
      ),
    ),
  );
}
