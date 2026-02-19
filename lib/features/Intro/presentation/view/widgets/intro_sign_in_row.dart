import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class IntroSignInRow extends StatelessWidget {
  const IntroSignInRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.intro_screen_already_have_account.tr(),
          style: Styles.styles16w400White,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, signInScreen);
          },
          child: Text(
            LocaleKeys.intro_screen_sign_in.tr(),
            style: Styles.styles16w500NormalWhite,
          ),
        ),
      ],
    );
  }
}
