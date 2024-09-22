

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';

import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/number_textfield.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:confetti/confetti.dart';

class VerficationChangesScreen extends StatefulWidget {
  final String? phoneNumber;
  const VerficationChangesScreen({super.key, this.phoneNumber});

  @override
  State<VerficationChangesScreen> createState() =>
      _VerficationChangesScreenState();
}

class _VerficationChangesScreenState extends State<VerficationChangesScreen> {
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

  bool isPlaying = false;
  final confetti = ConfettiController();

  void _focusNextNode(FocusNode currentFocus, FocusNode nextFocus) {
    if (!currentFocus.hasFocus) {
      return;
    }
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _resendCode() {
    setState(() {
      _countdownController.restart();
    });
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
  void initState() {
    super.initState();
    confetti.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundImage()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 60.h),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        returnArrow(context: context, onTap: (){
                Navigator.of(context).pop();
              }),
                        SizedBox(
                          width: 65.w,
                        ),
                        Text(
                          "Profile Information",
                          style: Styles.styles16w400grey
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Verify Phone Number",
                      style: Styles.styles25w600black,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
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
                                _focusNextNode(_focusNode1, _focusNode2),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: NumberTextField(
                            controller: _verificationCodeController2,
                            focusNode: _focusNode2,
                            onNext: () =>
                                _focusNextNode(_focusNode2, _focusNode3),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: NumberTextField(
                            controller: _verificationCodeController3,
                            focusNode: _focusNode3,
                            onNext: () =>
                                _focusNextNode(_focusNode3, _focusNode4),
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
                          showModalBottomSheet(
                              context: context,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.vertical( top : Radius.circular(30.r)) ,
                              // ),
                              builder: (context) {
                                confetti.play();
                                return Stack(
                       
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30.r),
                                              topRight: Radius.circular(30.r))),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                              "assets/Icons_logos/Property 1=Group 13.png"),
                                          Center(
                                            child: SizedBox(
                                              width: 340.w,
                                              child: Text(
                                                "Your Profile Information Updated Successfully",
                                                style: Styles.styles21w700black
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color
                                                            .fromRGBO(
                                                            36, 36, 36, 1)),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          SignUpCustomButton(
                                              buttonText: "Done",
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(homeLayout);
                                              })
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: MediaQuery.of(context).size.width*0.5,
                                      top: 60.h,
                                      child: ConfettiWidget(
                                          confettiController: confetti,
                                    
                                          blastDirectionality: BlastDirectionality.explosive,
                                          numberOfParticles: 12,
                                          gravity: 0.4,


                                          ),
                                    ),
                                  ],
                                );
                              });
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
                    SizedBox(height: 340.h),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
