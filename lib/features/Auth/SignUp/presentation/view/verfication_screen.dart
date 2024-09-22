import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/nh_logo.dart';

import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';

import 'widgets/number_textfield.dart';
import 'widgets/sign_up_app_bar.dart';
import 'widgets/sign_up_custom_button.dart';

class VerificationScreen extends StatefulWidget {
  final String? phoneNumber;

  const VerificationScreen({super.key, this.phoneNumber});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isEn = true;
  final TextEditingController _verificationCodeController1 =
      TextEditingController();
  final TextEditingController _verificationCodeController2 =
      TextEditingController();
  final TextEditingController _verificationCodeController3 =
      TextEditingController();
  final TextEditingController _verificationCodeController4 =
      TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final CountdownController _countdownController =
      CountdownController(autoStart: true);

  void _focusNextField(FocusNode currentFocus, FocusNode nextFocus) {
    if (!currentFocus.hasFocus) {
      return;
    }
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _resendCode() {
    setState(() {
      _countdownController.restart();
    });
    // Add the logic to resend the code here
  }

  @override
  void dispose() {
    _verificationCodeController1.dispose();
    _verificationCodeController2.dispose();
    _verificationCodeController3.dispose();
    _verificationCodeController4.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: BackgroundImage(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SignUpAppBar(
                    title: "",
                    isEn: isEn,
                    onLanguageChange: (bool value) {
                      setState(() {
                        isEn = value;
                      });
                    },
                  ),
                  SizedBox(height: 5.h),
                  const LogoWidget(),
                  SizedBox(height: 15.h),
                  Text(
                    "Verify Phone Number",
                    style: Styles.styles25w600Black,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "We have sent a code to your number +2${widget.phoneNumber}",
                    style: Styles.styles15w400Black,
                  ),
                  Text(
                    "Please enter the code sent",
                    style: Styles.styles15w400Black,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: NumberTextField(
                          controller: _verificationCodeController1,
                          focusNode: _focusNode1,
                          onNext: () =>
                              _focusNextField(_focusNode1, _focusNode2),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: NumberTextField(
                          controller: _verificationCodeController2,
                          focusNode: _focusNode2,
                          onNext: () =>
                              _focusNextField(_focusNode2, _focusNode3),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: NumberTextField(
                          controller: _verificationCodeController3,
                          focusNode: _focusNode3,
                          onNext: () =>
                              _focusNextField(_focusNode3, _focusNode4),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: NumberTextField(
                          controller: _verificationCodeController4,
                          focusNode: _focusNode4,
                          onNext: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: SignUpCustomButton(
                      buttonText: "Verify Now",
                      onPressed: () {
                        Navigator.of(context).pushNamed(confirmationScreen);
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Countdown(
                      controller: _countdownController,
                      seconds: 3600,
                      build: (BuildContext context, double time) {
                        final int minutes = (time / 60).floor();
                        final int seconds = (time % 60).toInt();
                        final String formattedMinutes =
                            minutes.toString().padLeft(2, '0');
                        final String formattedSeconds =
                            seconds.toString().padLeft(2, '0');

                        return Text(
                          '$formattedMinutes : $formattedSeconds',
                          style:
                              Styles.styles12w500Black.copyWith(fontSize: 15),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Center(
                    child: Text(
                      "Didn’t receive verification Code?",
                      style: Styles.styles15w400Black,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Center(
                    child: GestureDetector(
                      onTap: _resendCode,
                      child: Text(
                        "Resend Code",
                        style: Styles.styles15w700Gold,
                      ),
                    ),
                  ),
                  SizedBox(height: 280.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
