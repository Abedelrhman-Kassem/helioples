import 'package:d_dialog/d_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/trkey_helper.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Auth/auth_controller.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/cust_button_profail.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/profile_item.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    getislogin();
  }

  void getislogin() async {
    String? isLogin = await ServicesHelper.getLocal('token');
    token = isLogin;
  }

  void goToPage(
    BuildContext context,
    String pageIfNotLoggedIn,
    String pageIfLoggedIn,
  ) {
    if (token == null) {
      Navigator.of(context).pushNamed(pageIfNotLoggedIn);
    } else {
      Navigator.of(context).pushNamed(pageIfLoggedIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    List<ProfileItem> items = [
      ProfileItem(
        imagePath: "assets/svg_icons/profile_icon.svg",
        label: trKey(LocaleKeys.profile_screen_profile_information),
        onTap: () {
          goToPage(context, profileEmptyScreen, cahngeInformationScreen);
        },
      ),
      ProfileItem(
        imagePath: "assets/svg_icons/history_icon.svg",
        label: trKey(LocaleKeys.profile_screen_orders_history),
        onTap: () {
          goToPage(context, historyEmptyScreen, historyScreen);
          // Navigator.of(context).pushNamed(historyScreen);
        },
      ),
      ProfileItem(
        imagePath: "assets/svg_icons/alert_icon.svg",
        label: trKey(LocaleKeys.profile_screen_alerts),
        onTap: () {
          goToPage(context, alertsEmptyScreen, alertsScreen);
          // Navigator.of(context).pushNamed(alertsScreen);
        },
      ),
      ProfileItem(
        imagePath: "assets/svg_icons/settings_icon.svg",
        label: trKey(LocaleKeys.profile_screen_app_settings),
        onTap: () {
          Navigator.of(context).pushNamed(settingsScreen);
        },
      ),
      ProfileItem(
        imagePath: "assets/svg_icons/help_center_icon.svg",
        label: trKey(LocaleKeys.profile_screen_help_center),
        onTap: () {
          Navigator.of(context).pushNamed(helpCenterScreen);
        },
      ),
      ProfileItem(
        imagePath: "assets/svg_icons/chat_icon.svg",
        label: trKey(LocaleKeys.profile_screen_chat_with_us),
      ),
      ProfileItem(
        onTap: () async {
          if (authC.isLogged.value) {
            await DialogBackground(
              blur: 5,
              barrierColor: Colors.black.withValues(alpha: 0.2),
              dialog: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustButtonProfail(
                    title: trKey(
                      LocaleKeys.profile_screen_logout_now_dialog_title,
                    ),
                    onPressed: () async {
                      ServicesHelper.removeLocal('token');
                      final addressesCtrl = Get.find<AddressesControllerImpl>();
                      await addressesCtrl.fetchAddresses();
                      Navigator.of(context).pushReplacementNamed(homeLayout);
                      authC.logout();
                    },
                  ),
                  CustButtonProfail(
                    title: trKey(LocaleKeys.profile_screen_logout_cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ).show(context, transitionType: DialogTransitionType.bottomToTop);
          } else {
            Navigator.of(context).pushNamed(signInScreen);
          }
        },
        imagePath: authC.isLogged.value
            ? "assets/svg_icons/logout_icon.svg"
            : "assets/svg_icons/logout_icon.svg",
        label: authC.isLogged.value
            ? trKey(LocaleKeys.profile_screen_logout)
            : trKey(LocaleKeys.login_screen_login),
      ),
    ];

    HomeLayoutCubit homeLayoutCubit = BlocProvider.of<HomeLayoutCubit>(context);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundImage()),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 16.w,
                  top: 60.h,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      children: [
                        returnArrow(
                          context: context,
                          onTap: () {
                            homeLayoutCubit.returnIndex(context);
                          },
                        ),
                        SizedBox(width: 100.w),
                        Text(
                          trKey(LocaleKeys.profile_screen_user_profile),
                          style: Styles.styles17w600interFamily,
                        ),
                        SizedBox(width: 0.w),
                      ],
                    ),
                    SizedBox(height: 40.h),
                  ]),
                ),
              ),
              Obx(() {
                final isLogin = authC.isLogged.value;
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => items[index],
                      childCount: isLogin ? items.length : items.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 12.0,
                        ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
