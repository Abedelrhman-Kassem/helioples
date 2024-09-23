import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: returnArrow(context: context, onTap: (){
                Navigator.of(context).pop();
              })
            ),
            SizedBox(
              height: 50.h,
            ),
            Image.asset(
              "assets/Icons_logos/notification_logo.png",
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Allow Us To Send You ",
              style: Styles.styles25w600Black,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "notifications?",
              style: Styles.styles25w600Black,
            ),
            SizedBox(
              height: 20.h,
            ),
            SignUpCustomButton(
                buttonText: "Allow Notification", onPressed: () {}),
            SizedBox(
              height: 15.h,
            ),
            SignUpCustomButton(
              buttonText: "Maybe Later",
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
