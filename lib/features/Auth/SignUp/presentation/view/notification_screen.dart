import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:negmt_heliopolis/controller/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';

import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          children: [
            AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: returnArrow(
                    context: context,
                    onTap: () async {
                      Navigator.of(context).pop();
                      final addressesCtrl = Get.find<AddressesControllerImpl>();
                      await addressesCtrl.fetchAddresses();
                    })),
            // SizedBox(
            //   height: 20.h,
            // ),
            Image.asset(
              "assets/Icons_logos/notification_logo.png",
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              StringTranslateExtension(
                      LocaleKeys.notification_screen_allow_us_to_send)
                  .tr(),
              style: Styles.styles25w600Black,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              StringTranslateExtension(
                      LocaleKeys.notification_screen_notifications)
                  .tr(),
              style: Styles.styles25w600Black,
            ),
            SizedBox(
              height: 20.h,
            ),
            SignUpCustomButton(
                buttonText: StringTranslateExtension(
                        LocaleKeys.notification_screen_allow_notification)
                    .tr(),
                onPressed: () {}),
            SizedBox(
              height: 15.h,
            ),
            SignUpCustomButton(
              buttonText: StringTranslateExtension(
                      LocaleKeys.notification_screen_maybe_later)
                  .tr(),
              onPressed: () {},
              buttonColor: const Color.fromRGBO(0, 126, 143, 0.1),
              textColor: const Color.fromRGBO(0, 126, 143, 1),
            )
          ],
        ),
      ),
    );
  }
}
