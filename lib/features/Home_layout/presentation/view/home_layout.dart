import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/models/language/app_localizations.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view/widgets/gbutton.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit homeLayoutCubit =
              BlocProvider.of<HomeLayoutCubit>(context);

          return Scaffold(
            body: homeLayoutCubit.screens[homeLayoutCubit.selectedIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(75.r),
                ),
                boxShadow: [
                  MyBoxShadows.gNavBoxSahdow,
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.r),
                child: GNav(
                  textStyle: Styles.styles12w500sFProTextFamily,
                  selectedIndex: homeLayoutCubit.selectedIndex,
                  padding: EdgeInsets.all(13.r),
                  gap: 8.w,
                  tabBackgroundColor: MyColors.mainColor,
                  onTabChange: (index) {
                    homeLayoutCubit.changeCurrentIndex(index);
                  },
                  tabs: [
                    gButtonItem(
                      context: context,
                      activeSvgPath: 'assets/svg_icons/white-home.svg',
                      outlinedSvgPath: 'assets/svg_icons/home.svg',
                      text: 'home'.tr(context),
                      index: 0,
                    ),
                    gButtonItem(
                      context: context,
                      activeSvgPath: 'assets/svg_icons/white-search-normal.svg',
                      outlinedSvgPath: 'assets/svg_icons/search-normal.svg',
                      text: 'explore'.tr(context),
                      index: 1,
                    ),
                    gButtonItem(
                      context: context,
                      activeSvgPath: 'assets/svg_icons/white-heart.svg',
                      outlinedSvgPath: 'assets/svg_icons/heart.svg',
                      text: 'liked'.tr(context),
                      index: 2,
                    ),
                    gButtonItem(
                      context: context,
                      activeSvgPath: 'assets/svg_icons/white-favorite-Cart.svg',
                      outlinedSvgPath: 'assets/svg_icons/favorite-Cart.svg',
                      text: 'cart'.tr(context),
                      index: 3,
                    ),
                    gButtonItem(
                      context: context,
                      activeSvgPath: 'assets/svg_icons/white-user.svg',
                      outlinedSvgPath: 'assets/svg_icons/user.svg',
                      text: 'profile'.tr(context),
                      index: 4,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
