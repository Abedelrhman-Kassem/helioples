import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/loading_button.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/egypt_code_widget.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/sing_up_repo_imp.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view%20model/sign_up_cubit/sign_up_cubit.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view%20model/sign_up_cubit/sign_up_states.dart';

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

  DateTime dateTime = DateTime.now();
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
                    title: "Register",
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
                          isPassword: false,
                          
                          labelText: "First Name",
                          controller: firstNameController,
                          isEnabled: true,
                         
                          
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: NameTextField(
                          isPassword: false,
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
                      "Phone Number",
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 14.h),
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
                      "Birthday Date",
                      style: Styles.styles14w400NormalBlack,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(246, 246, 246, 1),
                      iconColor: MyColors.mainColor,
                      focusColor: MyColors.mainColor,
                      hintText:
                          '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/svg_icons/calendar.svg',
                          width: 30.w,
                          height: 30.h,
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
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.h),
                    ),
                    style: Styles.styles17w500NormalBlack,
                    readOnly: true,
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.r),
                              topRight: Radius.circular(30.r),
                            ),
                          ),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.white,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: CupertinoDatePicker(
                                  backgroundColor: Colors.white,
                                  onDateTimeChanged: (DateTime newDate) {
                                    setState(() {
                                      dateTime = newDate;
                                    });
                                  },
                                  use24hFormat: true,
                                  mode: CupertinoDatePickerMode.date,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  BlocProvider(
                    create: (context) =>
                        SignUpCubit(SignUpRepoImp(apiService: ApiService())),
                    child: BlocConsumer<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        // ignore: unused_local_variable
                        var cubit = BlocProvider.of<SignUpCubit>(context);
                        if (state is SignUpLoading) {
                          return const LoadingButton(
                            height: 60,
                            radius: 10,
                          );
                        } else {
                          return Center(
                            child: SignUpCustomButton(
                              buttonText: "Continue",
                              onPressed: () {
                                // User user = User(
                                //     firstName: firstNameController.text,
                                //     lastName: lastNameController.text,
                                //     phone: phoneNumberController.text,
                                //     password: "123456",
                                //     birthdate: "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                                //     email: "omarsal@gmail.com");

                                // cubit.singUp(user);
                                Navigator.of(context).pushNamed(
                                  verficationScreen,
                                  arguments: {
                                    'phoneNumber': phoneNumberController.text,
                                  },
                                );
                              },
                            ),
                          );
                        }
                      },
                      listener: (context, state) {
                        if (state is SignUpFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)));
                        } else if (state is SignUpSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please Enter Validaition code')));
                          Navigator.of(context).pushNamed(
                            verficationScreen,
                            arguments: {
                              'phoneNumber': phoneNumberController.text,
                            },
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have An Account?",
                          style: Styles.styles15w400NormalBlack,
                        ),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Login Now",
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
