import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';

import 'package:negmt_heliopolis/core/widgets/loading_button.dart';
import 'package:negmt_heliopolis/features/Auth/Login/data/repo/log_in_repo_imp.dart';

import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/sign%20in%20cubit/sign_in_cubit.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/sign%20in%20cubit/sign_in_states.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/name_textfield.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/nh_logo.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/phone_number_row.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_app_bar.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  getToken() async {
    String? myToken = await FirebaseMessaging.instance.getToken();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    log("token : $myToken");
  }

  myRequestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    myRequestPermission();
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignUpAppBar(
                    title: "Login",
                    isEn: true,
                    onLanguageChange: (bool value) {
                      setState(() {
                        // isEn = value;
                      });
                    }),
                SizedBox(height: 5.h),
                const LogoWidget(),
                SizedBox(height: 15.h),

                // Text(
                //   "Enter Phone Number",
                //   style: Styles.styles25w600black.copyWith(color: const Color.fromRGBO(40, 40, 40, 1)),
                //   // style: const TextStyle(
                //   //     fontSize: 28, fontWeight: FontWeight.bold),
                // ),
                PhoneNumberRow(
                  controller: phoneNumberController,
                  labelText: "Phone Number",
                ),
                SizedBox(
                  height: 12.h,
                ),
                NameTextField(
                  labelText: "Password",
                  controller: PasswordController,
                  isEnabled: true,
                  isPassword: true,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Center(
                  child: Text(
                    'You will receive a verification code',
                    style: Styles.styles15w400Black
                        .copyWith(color: const Color.fromRGBO(80, 80, 80, 1)),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),

                BlocProvider(
                  create: (context) =>
                      SignInCubit((LogInRepoImp(apiService: ApiService()))),
                  child: BlocConsumer<SignInCubit, SignInState>(
                      builder: (context, state) {
                    var cubit = BlocProvider.of<SignInCubit>(context);
                    if (state is SignInLoading) {
                      return const LoadingButton(
                        height: 60,
                        radius: 10,
                      );
                    } else {
                      return Center(
                        child: SignUpCustomButton(
                          buttonText: "Continue",
                          onPressed: () {
                            cubit.signIn("1145243378", "12345678");
                            //  Navigator.of(context).pushNamed(
                            //   verficationScreen,
                            //   arguments: {
                            //     'phoneNumber': "+201145243378",
                            //   },
                            // );
                          },
                        ),
                      );
                    }
                  }, listener: (context, state) {
                    if (state is SignInFailure) {
                      CustomSnackBar.show(
                        context: context,
                        duration: const Duration(milliseconds: 5000),
                        text: state.errorMessage,
                        isGreen: false,
                      );
                    } else if (state is SignInSuccess) {
                      CustomSnackBar.show(
                        context: context,
                        duration: const Duration(milliseconds: 5000),
                        text: 'We already sent a verification code',
                        isGreen: true,
                      );

                      Navigator.of(context).pushNamed(
                        verficationScreen,
                        arguments: {
                          'phoneNumber': "1145243378",
                        },
                      );
                    }
                  }),
                ),
                // CustomButton(
                //   text: "Continue",
                //   onTap: () {
                //     // Navigator.pushNamed(context, verficationScreen);
                //   },
                //   backgroundColor: MyColors.mainColor,
                //   textColor: MyColors.mainScaffoldWhiteColor,
                //   verticalPadding: 15,
                //   borderRadius: 20,
                // ),
                SizedBox(
                  height: 16.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "Don’t Have Account? ",
                            style: Styles.styles15w400Black),
                        TextSpan(
                          text: "Register Now",
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
                SizedBox(
                  height: 26.h,
                ),
                Center(
                  child: Text(
                    "Or",
                    style: Styles.styles16w600NormalBlack,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Container(
                    height: 52.h,
                    width: 194.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(43.r),
                        border: Border.all(
                            color: MyColors.mainColor, width: 2.5.w)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(homeLayout);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Shop Now",
                            style: Styles.styles17w500MainColor
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Image.asset(
                              "assets/Icons_logos/arrow-circle-right.png")
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("settings"),
//       ),
//       body: Center(
//         child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: BlocConsumer<LocaleCubit, ChangeLocaleState>(
//               listener: (context, state) {
//                 Navigator.of(context).pop();
//               },
//               builder: (context, state) {
//                 return DropdownButton<String>(
//                   value: state.locale.languageCode,
//                   icon: const Icon(Icons.keyboard_arrow_down),
//                   items: ['ar', 'en'].map((String items) {
//                     return DropdownMenuItem<String>(
//                       value: items,
//                       child: Text(items),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       context.read<LocaleCubit>().changeLanguage(newValue);
//                     }
//                   },
//                 );
//               },
//             )),
//       ),
//     );
//   }
// }

// class CustomSnackBar {
//   static void show(BuildContext context, String message, String iconPath) {
//     // Animation Controller
//     final animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: Scaffold.of(context), // Ensure this uses a TickerProvider
//     );

//     final animation = Tween<Offset>(
//       begin: const Offset(0, 1), // Start off the screen at the bottom
//       end: Offset.zero, // Move to original position
//     ).animate(CurvedAnimation(
//       parent: animationController,
//       curve: Curves.easeOut,
//     ));

//     // Create the overlay entry
//     final overlayEntry = OverlayEntry(
//       builder: (context) {
//         return SlideTransition(
//           position: animation,
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: const Color.fromRGBO(213, 255, 236, 1),
//                 borderRadius: BorderRadius.circular(60),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset(
//                     iconPath,
//                     height: 24,
//                     width: 24,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     message,
//                     style: const TextStyle(
//                       color: Color.fromRGBO(59, 183, 126, 1),
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );

//     // Insert the overlay entry
//     Overlay.of(context).insert(overlayEntry);
//     animationController.forward();

//     // Remove after delay with animation
//     Future.delayed(const Duration(milliseconds: 5000), () {
//       animationController.reverse().then((_) {
//         overlayEntry.remove();
//         animationController.dispose();
//       });
//     });
//   }
// }
