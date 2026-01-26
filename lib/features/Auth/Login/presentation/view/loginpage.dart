import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/trkey_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/core/widgets/loading_button.dart';
import 'package:negmt_heliopolis/features/Auth/Login/data/repo/log_in_repo_imp.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/models/login_model.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/nh_logo.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/sign%20in%20cubit/sign_in_cubit.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/sign%20in%20cubit/sign_in_states.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/phone_number_row.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_app_bar.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController(
    text: "01",
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String lang = getLocale(context);

    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/screens_background/grocery_itemsback_ground.png",
          ),
          fit: BoxFit.cover,
        ),
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SignUpAppBar(
                    title: LocaleKeys.login_screen_login.tr(),
                    // isEn: true,
                    onLanguageChange: (bool value) {
                      if (lang == 'ar') {
                        changeLocal(context, 'en');
                      } else {
                        changeLocal(context, 'ar');
                      }
                    },
                  ),
                  SizedBox(height: 5.h),
                  const LogoWidget(),
                  SizedBox(height: 15.h),
                  Center(
                    child: PhoneNumberRow(
                      controller: phoneNumberController,
                      labelText: LocaleKeys.login_screen_phone_number.tr(),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      LocaleKeys.login_screen_verification_info.tr(),
                      style: Styles.styles15w400Black.copyWith(
                        color: const Color.fromRGBO(80, 80, 80, 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  BlocProvider(
                    create: (context) => SignInCubit(
                      (LogInRepoImp(apiService: Get.find<ApiService>())),
                    ),
                    child: BlocConsumer<SignInCubit, SignInStates>(
                      builder: (context, state) {
                        var cubit = BlocProvider.of<SignInCubit>(context);

                        return state.maybeWhen(
                          orElse: () => Center(
                            child: SignUpCustomButton(
                              buttonText: LocaleKeys.login_screen_continue.tr(),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.signIn(phoneNumberController.text);
                                }
                              },
                            ),
                          ),
                          loading: () =>
                              const LoadingButton(height: 60, radius: 10),
                        );
                      },
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          success: (LoginModel result) {
                            showCustomGetSnack(
                              isGreen: true,
                              text: trKey(
                                LocaleKeys.login_screen_verification_code_sent,
                              ),
                            );

                            Navigator.of(context).pushNamed(
                              verficationLoginScreen,
                              arguments: {'loginModel': result},
                            );
                          },
                          failure: (String errorMessage) {
                            showCustomGetSnack(
                              isGreen: false,
                              text: errorMessage,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: LocaleKeys.login_screen_no_account.tr(),
                            style: Styles.styles15w400Black,
                          ),
                          TextSpan(
                            text: LocaleKeys.login_screen_register_now.tr(),
                            style: Styles.styles15w700Gold,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, signUpScreen);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 26.h),
                  Center(
                    child: Text(
                      LocaleKeys.login_screen_or.tr(),
                      style: Styles.styles16w600NormalBlack,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Container(
                      height: 52.h,
                      width: 194.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(43.r),
                        border: Border.all(
                          color: MyColors.mainColor,
                          width: 2.5.w,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(homeLayout);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.login_screen_shop_now.tr(),
                              style: Styles.styles17w500MainColor.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Image.asset(
                              "assets/Icons_logos/arrow-circle-right.png",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
