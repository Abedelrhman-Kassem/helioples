import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/settings_item.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedMode = LocaleKeys.settings_screen_light_mode.tr();

  @override
  Widget build(BuildContext context) {
    String selectedLang = getLocale(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          top: 60.h,
          bottom: 10.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                returnArrow(
                  context: context,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 100.w),
                Text(
                  LocaleKeys.settings_screen_app_settings.tr(),
                  style: Styles.styles16w400Black,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SettingsItem(
              leadingIconPath: "assets/svg_icons/change_language_icon.svg",
              title: LocaleKeys.settings_screen_change_language.tr(),
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
                              fillColor: WidgetStateProperty.all(
                                MyColors.mainColor,
                              ), // Customize the radio button color
                              overlayColor: WidgetStateProperty.all(
                                const Color.fromRGBO(110, 110, 110, 1),
                              ),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            // height: MediaQuery.of(context).size.height * 0.5.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 25.h,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15.w,
                                          ),
                                          child: Text(
                                            LocaleKeys
                                                .settings_screen_change_language
                                                .tr(),
                                            style: Styles.styles15w400Black,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Image.asset(
                                            "assets/Icons_logos/x.png",
                                          ),
                                        ),
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
                                        LocaleKeys.settings_screen_english.tr(),
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
                                        LocaleKeys.settings_screen_arabic.tr(),
                                        style: Styles.styles15w400Black,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    SignUpCustomButton(
                                      buttonText: LocaleKeys
                                          .settings_screen_update_language
                                          .tr(),
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
                          ),
                        );
                      },
                    );
                  },
                );
              },
              trailingIconPath: "assets/svg_icons/sittengs_arrow_icon.svg",
            ),
            SizedBox(height: 20.h),
            // SettingsItem(
            //   leadingIconPath: "assets/svg_icons/dark_mode_icon.svg",
            //   title: LocaleKeys.settings_screen_app_mode.tr(),
            //   onTap: () {
            //     showModalBottomSheet(
            //       context: context,
            //       isScrollControlled: true,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.vertical(
            //           top: Radius.circular(30.r),
            //         ),
            //       ),
            //       builder: (context) {
            //         return StatefulBuilder(
            //           builder: (context, setState) {
            //             return Theme(
            //               data: Theme.of(context).copyWith(
            //                 radioTheme: RadioThemeData(
            //                   fillColor: WidgetStateProperty.all(
            //                     MyColors.mainColor,
            //                   ),
            //                   overlayColor: WidgetStateProperty.all(
            //                     const Color.fromRGBO(110, 110, 110, 1),
            //                   ),
            //                 ),
            //               ),
            //               child: Container(
            //                 width: double.infinity,
            //                 // height: MediaQuery.of(context).size.height * 0.32,
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.only(
            //                     topLeft: Radius.circular(30.r),
            //                     topRight: Radius.circular(30.r),
            //                   ),
            //                 ),
            //                 child: Padding(
            //                   padding: EdgeInsets.symmetric(
            //                     horizontal: 10.w,
            //                     vertical: 25.h,
            //                   ),
            //                   child: SingleChildScrollView(
            //                     child: Column(
            //                       mainAxisSize: MainAxisSize.min,
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       children: [
            //                         Row(
            //                           children: [
            //                             Padding(
            //                               padding: EdgeInsets.symmetric(
            //                                 horizontal: 15.w,
            //                               ),
            //                               child: Text(
            //                                 LocaleKeys.settings_screen_app_mode
            //                                     .tr(),
            //                                 style: Styles.styles15w400Black,
            //                               ),
            //                             ),
            //                             const Spacer(),
            //                             GestureDetector(
            //                               onTap: () {
            //                                 Navigator.of(context).pop();
            //                               },
            //                               child: Image.asset(
            //                                 "assets/Icons_logos/x.png",
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         Row(
            //                           children: [
            //                             RadioMenuButton<String>(
            //                               value: LocaleKeys
            //                                   .settings_screen_light_mode
            //                                   .tr(),
            //                               groupValue: selectedMode,
            //                               onChanged: (value) {
            //                                 setState(() {
            //                                   selectedMode = value!;
            //                                 });

            //                                 this.setState(() {
            //                                   selectedMode = value!;
            //                                 });
            //                               },
            //                               child: Text(
            //                                 LocaleKeys
            //                                     .settings_screen_light_mode
            //                                     .tr(),
            //                                 style: Styles.styles15w400Black,
            //                               ),
            //                             ),
            //                             const Spacer(),
            //                             Image.asset(
            //                               "assets/Icons_logos/white_circle.png",
            //                             ),
            //                           ],
            //                         ),
            //                         Row(
            //                           children: [
            //                             RadioMenuButton<String>(
            //                               value: LocaleKeys
            //                                   .settings_screen_dark_mode
            //                                   .tr(),
            //                               groupValue: selectedMode,
            //                               onChanged: (value) {
            //                                 setState(() {
            //                                   selectedMode = value!;
            //                                 });

            //                                 this.setState(() {
            //                                   selectedMode = value!;
            //                                 });
            //                               },
            //                               child: Text(
            //                                 LocaleKeys.settings_screen_dark_mode
            //                                     .tr(),
            //                                 style: Styles.styles15w400Black,
            //                               ),
            //                             ),
            //                             const Spacer(),
            //                             Image.asset(
            //                               "assets/Icons_logos/black_circle.png",
            //                             ),
            //                           ],
            //                         ),
            //                         SizedBox(height: 10.h),
            //                         SignUpCustomButton(
            //                           buttonText: LocaleKeys
            //                               .settings_screen_update_mode
            //                               .tr(),
            //                           onPressed: () {
            //                             Navigator.of(context).pop();
            //                           },
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         );
            //       },
            //     );
            //   },
            //   trailingIconPath: "assets/svg_icons/sittengs_arrow_icon.svg",
            // ),
            SizedBox(height: 20.h),
            // SettingsItem(
            //   leadingIconPath: "assets/svg_icons/delete_acc_icon.svg",
            //   title: LocaleKeys.settings_screen_delete_account.tr(),
            //   onTap: () {},
            //   trailingIconPath: "assets/svg_icons/sittengs_arrow_icon.svg",
            // ),
          ],
        ),
      ),
    );
  }
}
