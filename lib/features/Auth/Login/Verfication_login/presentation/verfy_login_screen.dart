import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/core/widgets/loading_button.dart';
import 'package:negmt_heliopolis/features/Auth/Login/Verfication_login/data/cubit/verfy_login_cubit.dart';
import 'package:negmt_heliopolis/features/Auth/Login/Verfication_login/data/cubit/verfy_login_states.dart';
import 'package:negmt_heliopolis/features/Auth/Login/Verfication_login/presentation/timer_resend_login.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_app_bar.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/presentation/timer_resend.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/nh_logo.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class VerfyLoginScreen extends StatefulWidget {
  const VerfyLoginScreen({
    super.key,
  });

  @override
  State<VerfyLoginScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerfyLoginScreen> {
  bool isEn = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerfyLoginCubit>();
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
                              'phoneNumber': cubit.loginModel?.phoneNumber ?? ''
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
                              BlocBuilder<VerfyLoginCubit, VerfyLoginStates>(
                                builder: (context, state) {
                                  final cubit = context.read<VerfyLoginCubit>();
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
                                      cubit.verifyOtpAndLogin(verificationCode);
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
                    BlocConsumer<VerfyLoginCubit, VerfyLoginStates>(
                      listener: (context, state) {
                        if (state is VerfyLoginFailure) {
                          showCustomGetSnack(
                              duration: const Duration(minutes: 10),
                              isGreen: false,
                              text: state.errorMessage);
                        }

                        if (state is VerfyLoginSuccess) {
                          showCustomGetSnack(
                              isGreen: true, text: "we send you a new code");
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            homeLayout,
                            (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is VerfyLoginLoading) {
                          return const LoadingButton(
                            height: 60,
                            radius: 10,
                          );
                        }

                        return Center(
                          child: SignUpCustomButton(
                            buttonText: StringTranslateExtension(
                              LocaleKeys.verification_screen_verify_now,
                            ).tr(),
                            onPressed: () {
                              // cubit.verifyOtpAndLogin(smsCode)
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                        height: 200.h,
                        width: 400.w,
                        child: const TimerResendLogin()),
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
