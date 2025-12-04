import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringTranslateExtension(
                    LocaleKeys.signup_screen_already_have_account)
                .tr(),
            style: Styles.styles15w400NormalBlack,
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              StringTranslateExtension(LocaleKeys.signup_screen_login_now).tr(),
              style: Styles.styles15w700Gold,
            ),
          ),
        ],
      ),
    );
  }
}
