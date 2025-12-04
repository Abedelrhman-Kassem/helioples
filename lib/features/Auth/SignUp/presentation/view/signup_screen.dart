import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/core/widgets/loading_button.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/send_otp_imp.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view_model/sign_up_cubit/send_otp_cubit.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view_model/sign_up_cubit/sent_otp_states.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/cust_body_register.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/have_an_account_widget.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/nh_logo.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/phone_number_widget.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_app_bar.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/text_form_date.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/model/register_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: 'mohamed');
  final TextEditingController lastNameController =
      TextEditingController(text: 'mohamed');
  final TextEditingController phoneNumberController =
      TextEditingController(text: '01201855485');
  final TextEditingController birthdayDateController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    birthdayDateController.dispose();
  }

  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final String lang = getLocale(context);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundImage()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SignUpAppBar(
                      title: StringTranslateExtension(
                              LocaleKeys.signup_screen_register)
                          .tr(),
                      onLanguageChange: (bool value) {
                        if (lang == 'ar') {
                          changeLocal(context, 'en');
                        } else {
                          changeLocal(context, 'ar');
                        }
                        setState(() {});
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          formKey.currentState?.validate();
                        });
                      },
                    ),
                    SizedBox(height: 5.h),
                    const LogoWidget(),
                    SizedBox(height: 15.h),
                    CustBodyRegister(
                      firstNameController: firstNameController,
                      lastNameController: lastNameController,
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        StringTranslateExtension(
                                LocaleKeys.signup_screen_phone_number)
                            .tr(),
                        style: Styles.styles14w400NormalBlack,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    PhoneNumberWidget(
                        phoneNumberController: phoneNumberController),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        StringTranslateExtension(
                                LocaleKeys.signup_screen_birthday_date)
                            .tr(),
                        style: Styles.styles14w400NormalBlack,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFormDate(
                      dateTime: dateTime,
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          dateTime = newDate;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    BlocProvider(
                      create: (context) => SendOtpCubit(SendOtpRepoImpl()),
                      child: BlocConsumer<SendOtpCubit, SentOtpState>(
                        builder: (context, state) {
                          // ignore: unused_local_variable
                          var cubit = BlocProvider.of<SendOtpCubit>(context);
                          if (state is SentOtpLoading) {
                            return const LoadingButton(
                              height: 60,
                              radius: 10,
                            );
                          } else {
                            return Center(
                              child: SignUpCustomButton(
                                buttonText: StringTranslateExtension(
                                        LocaleKeys.signup_screen_continue)
                                    .tr(),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterModel registerModel = RegisterModel(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      phone: phoneNumberController.text,
                                      birthdate:
                                          "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                                    );
                                    cubit.sendOtp(registerModel);
                                  }
                                },
                              ),
                            );
                          }
                        },
                        listener: (context, state) {
                          if (state is SentOtpFailure) {
                            log(state.errorMessage);
                            showCustomGetSnack(
                              duration: const Duration(minutes: 10),
                              isGreen: false,
                              text: state.errorMessage,
                            );
                          } else if (state is SentOtpSuccess) {
                            showCustomGetSnack(
                              isGreen: true,
                              text: "we have sent you a verification code",
                            );
                            Navigator.of(context).pushNamed(
                              verficationScreen,
                              arguments: {
                                'otpModel': state.otpModel,
                              },
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    const HaveAnAccountWidget(),
                    SizedBox(height: 300.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
