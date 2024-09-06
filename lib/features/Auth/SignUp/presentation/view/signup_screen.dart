import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/models/language/app_localizations.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/egypt_code_widget.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/Date_picker.dart';

import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/name_textfield.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/nh_logo.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_app_bar.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isEn = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthdayDateController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    birthdayDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundImage()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SignUpAppBar(
                    title: "Register".tr(context),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: NameTextField(
                          labelText: "First Name",
                          controller: firstNameController,
                          isEnabled: true,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: NameTextField(
                          labelText: "Last Name",
                          controller: lastNameController,
                          isEnabled: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      "Phone Number".tr(context),
                      style: Styles.styles14w400NormalBlack,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      const EgyptionCodeWidget(),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(246, 246, 246, 1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.r),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(210, 210, 210, 1),
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.r),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(210, 210, 210, 1),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.r),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(210, 210, 210, 1),
                                width: 1.5,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                          ),
                          style: Styles.styles17w500NormalBlack,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      "Birthday Date".tr(context),
                      style: Styles.styles14w400NormalBlack,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  const DatePicker(labelText: " "),
                  SizedBox(height: 20.h),
                  Center(
                    child: SignUpCustomButton(
                      buttonText: "Continue".tr(context),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          verficationScreen,
                          arguments: {
                            'phoneNumber': phoneNumberController.text,
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have An Account?".tr(context),
                          style: Styles.styles15w400NormalBlack,
                        ),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Login Now".tr(context),
                            style: Styles.styles15w700Gold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 300.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
