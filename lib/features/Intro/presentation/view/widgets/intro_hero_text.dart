import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class IntroHeroText extends StatelessWidget {
  const IntroHeroText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: LocaleKeys.intro_screen_better.tr(),
        style: Styles.styles40w800NormalWhite,
        children: [
          TextSpan(
            text: LocaleKeys.intro_screen_prices.tr(),
            style: Styles.styles40w400NormalWhite,
          ),
          TextSpan(text: '\n', style: Styles.styles40w400NormalWhite),
          TextSpan(
            text: LocaleKeys.intro_screen_faster.tr(),
            style: Styles.styles40w400NormalWhite,
          ),
          TextSpan(
            text: LocaleKeys.intro_screen_delivery.tr(),
            style: Styles.styles40w800NormalWhite,
          ),
        ],
      ),
    );
  }
}
