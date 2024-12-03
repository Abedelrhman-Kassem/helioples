import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart'; // Import the flutter_svg package

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool isCopied = false;
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
              height: 200.h,
            ),
            Center(
              child: Text(
                "Your account has been created successfully!",
                textAlign: TextAlign.center,
                style: Styles.styles24w400Black,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Welcome to the board, you got a 10 % promocode ",
                  style: Styles.styles16w400grey,
                  children: [
                    TextSpan(
                      text: "5511AS158",
                      style: Styles.styles16w400grey.copyWith(
                          color: const Color.fromRGBO(0, 126, 143, 1)),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isCopied = true;
                });
              },
              child: SvgPicture.asset("assets/svg_icons/copy-success.svg"),
            ),
            SizedBox(
              height: 15.h,
            ),
            isCopied
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Promocode",
                        style: Styles.styles12w400black,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Copied",
                            style: Styles.styles12w400black,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          SvgPicture.asset(
                            "assets/svg_icons/true.svg",
                            height: 10.h,
                            width: 10.w,
                          )
                        ],
                      )
                    ],
                  )
                : Container(),
            const Spacer(),
            SignUpCustomButton(
                buttonText: "Allow Location Access", onPressed: () {
                   Navigator.pushReplacementNamed(
                                  context,
                                  homeLayout,
                                );
                  
                }),
            SizedBox(
              height: 15.h,
            ),
            SignUpCustomButton(
              buttonText: "Enter Location Manually",
              onPressed: () {
                Navigator.of(context).pushNamed(setLocationScreen);
              },
              buttonColor: const Color.fromRGBO(0, 126, 143, 0.1),
              textColor: const Color.fromRGBO(0, 126, 143, 1),
            )
          ],
        ),
      ),
    );
  }
}
