import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/settings_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedMode = "Light Mode";

  @override
  Widget build(BuildContext context) {
    String selectedLang = getLocale(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(
            start: 16.w, end: 16.w, top: 60.h, bottom: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                returnArrow(
                    context: context,
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                  width: 100.w,
                ),
                Text(
                  "App Settings",
                  style: Styles.styles16w400Black,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            SettingsItem(
              leadingIconPath: "assets/svg_icons/change_language_icon.svg",
              title: "Change Language",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.r),
                    ),
                  ),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            radioTheme: RadioThemeData(
                              fillColor: WidgetStateProperty.all(MyColors
                                  .mainColor), // Customize the radio button color
                              overlayColor: WidgetStateProperty.all(
                                  const Color.fromRGBO(110, 110, 110, 1)),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 25.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        child: Text(
                                          "Change Language",
                                          style: Styles.styles15w400Black,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Image.asset(
                                            "assets/Icons_logos/x.png"),
                                      )
                                    ],
                                  ),
                                  RadioMenuButton<String>(
                                    value: 'en',
                                    groupValue: selectedLang,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedLang = value!;
                                      });

                                      this.setState(() {
                                        selectedLang = value!;
                                      });
                                    },
                                    child: Text(
                                      "English",
                                      style: Styles.styles15w400Black,
                                    ),
                                  ),
                                  RadioMenuButton<String>(
                                    value: 'ar',
                                    groupValue: selectedLang,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedLang = value!;
                                      });

                                      this.setState(() {
                                        selectedLang = value!;
                                      });
                                    },
                                    child: Text(
                                      "Arabic (العربية)",
                                      style: Styles.styles15w400Black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SignUpCustomButton(
                                    buttonText: "Update language",
                                    onPressed: () {
                                      if (selectedLang == 'en') {
                                        changeLocal(context, 'en');
                                      } else {
                                        changeLocal(context, 'ar');
                                      }

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              trailingIconPath: "assets/svg_icons/sittengs_arrow_icon.svg",
            ),
            SizedBox(
              height: 20.h,
            ),
            SettingsItem(
              leadingIconPath: "assets/svg_icons/dark_mode_icon.svg",
              title: "App Mode",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.r),
                    ),
                  ),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            radioTheme: RadioThemeData(
                              fillColor:
                                  WidgetStateProperty.all(MyColors.mainColor),
                              overlayColor: WidgetStateProperty.all(
                                  const Color.fromRGBO(110, 110, 110, 1)),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 25.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        child: Text(
                                          "App Mode",
                                          style: Styles.styles15w400Black,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Image.asset(
                                            "assets/Icons_logos/x.png"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RadioMenuButton<String>(
                                        value: 'Light Mode',
                                        groupValue: selectedMode,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedMode = value!;
                                          });

                                          this.setState(() {
                                            selectedMode = value!;
                                          });
                                        },
                                        child: Text(
                                          "Light Mode",
                                          style: Styles.styles15w400Black,
                                        ),
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                          "assets/Icons_logos/white_circle.png"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RadioMenuButton<String>(
                                        value: 'Dark Mode',
                                        groupValue: selectedMode,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedMode = value!;
                                          });

                                          this.setState(() {
                                            selectedMode = value!;
                                          });
                                        },
                                        child: Text(
                                          "Dark Mode",
                                          style: Styles.styles15w400Black,
                                        ),
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                          "assets/Icons_logos/black_circle.png"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SignUpCustomButton(
                                      buttonText: "Update Mode",
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              trailingIconPath: "assets/svg_icons/sittengs_arrow_icon.svg",
            ),
            SizedBox(
              height: 20.h,
            ),
            SettingsItem(
              leadingIconPath: "assets/svg_icons/delete_acc_icon.svg",
              title: "Delete Account",
              onTap: () {},
              trailingIconPath: "assets/svg_icons/sittengs_arrow_icon.svg",
            ),
          ],
        ),
      ),
    );
  }
}
