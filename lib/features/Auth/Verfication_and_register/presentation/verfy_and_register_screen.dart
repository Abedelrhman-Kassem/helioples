import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/core/widgets/loading_button.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_app_bar.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/cubit/verfy_and_register_cubit.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/cubit/verfy_and_register_states.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/presentation/timer_resend.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/nh_logo.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/home_screen.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    super.key,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isEn = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerfyAndRegisterCubit>();
    // يمكنك الّآن تسجيل القيم:
    log('verificationId: ${cubit.otpModel.verificationId}');
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: BackgroundImage(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: SingleChildScrollView(
              child: Builder(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SignUpAppBar(
                            title: "",
                            isEn: isEn,
                            onLanguageChange: (bool value) {
                              log('value: $value');
                              setState(() {
                                isEn = value;
                              });
                            },
                          ),
                          SizedBox(height: 5.h),
                          const LogoWidget(),
                          SizedBox(height: 15.h),
                          Text(
                            StringTranslateExtension(LocaleKeys
                                    .verification_screen_verify_phone_number)
                                .tr(),
                            style: Styles.styles25w600Black,
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            StringTranslateExtension(LocaleKeys
                                    .verification_changes_screen_sent_code_to)
                                .tr(namedArgs: {
                              'phoneNumber': cubit.otpModel.registerModel.phone,
                            }),
                            style: Styles.styles15w400Black,
                          ),
                          Text(
                            StringTranslateExtension(LocaleKeys
                                    .verification_screen_please_enter_code)
                                .tr(),
                            style: Styles.styles15w400Black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              BlocBuilder<VerfyAndRegisterCubit,
                                  VerfAndRegisterStates>(
                                builder: (context, state) {
                                  final cubit =
                                      context.read<VerfyAndRegisterCubit>();
                                  return OtpTextField(
                                    // key: ValueKey(cubit.clearText), // <- مهم: يجبر إعادة الإنشاء
                                    clearText: cubit.clearText,
                                    fieldWidth: 90.w,
                                    fieldHeight: 60.h,
                                    filled: true,
                                    enabledBorderColor: Colors.grey.shade300,
                                    focusedBorderColor: MyColors.mainColor,
                                    fillColor: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(35.r),
                                    numberOfFields: 6,
                                    borderColor: Colors.grey,
                                    showFieldAsBox: true,
                                    onCodeChanged: (String code) {},
                                    onSubmit: (String verificationCode) {
                                      cubit.verifyOtpAndRegister(
                                          verificationCode);
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    BlocConsumer<VerfyAndRegisterCubit, VerfAndRegisterStates>(
                      listener: (context, state) {
                        state.maybeWhen(
                          verfOtpFailure: (failure) {
                            showCustomGetSnack(
                                duration: const Duration(minutes: 10),
                                isGreen: false,
                                text: failure.errorMessage);
                          },
                          registerFailure: (errorMessage) {
                            log("RegisterFailure  $errorMessage");
                            showCustomGetSnack(
                                isSnackOpen: false,
                                duration: const Duration(minutes: 10),
                                isGreen: false,
                                text: errorMessage);
                          },
                          verfOtpSuccess: (result) {
                            showCustomGetSnack(
                                isGreen: true,
                                text: "success verification creating account");
                          },
                          registerSuccess: (result) {
                            showCustomGetSnack(
                                isSnackOpen: false,
                                isGreen: true,
                                text: " success creating account");
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              homeLayout,
                              (route) => false,
                            );
                          },
                          orElse: () {},
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          verfOtpLoading: () => const LoadingButton(
                            height: 60,
                            radius: 10,
                          ),
                          registerLoading: () => const LoadingButton(
                            height: 60,
                            radius: 10,
                          ),
                          orElse: () => Center(
                            child: SignUpCustomButton(
                              buttonText: StringTranslateExtension(
                                LocaleKeys.verification_screen_verify_now,
                              ).tr(),
                              onPressed: () {
                                cubit.register();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                        height: 200.h,
                        width: 400.w,
                        child: const TimerResend()),
                    SizedBox(height: 280.h),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
