import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class IntroCtaButton extends StatelessWidget {
  const IntroCtaButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = isRtl(context);

    return IconButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, homeLayout);
      },
      icon: Container(
        width: 268.w,
        height: 66.h,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 174, 198, 1),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.intro_screen_start_shopping.tr(),
              style: Styles.styles20w500NormalWhite,
            ),
            SizedBox(width: 10.w),
            Transform.rotate(
              angle: isAr ? 135 : 0,
              child: svgIcon(
                path: 'assets/svg_icons/arrow-circle-right.svg',
                width: 24.16.w,
                height: 24.16.h,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
