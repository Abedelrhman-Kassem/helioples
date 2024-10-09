import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view/widgets/gbutton.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view_model/cubit/home_screen_cubit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeLayoutCubit(),
        ),
        BlocProvider(
          create: (context) => HomeScreenCubit()..getAllCategories(),
        ),
      ],
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit homeLayoutCubit =
              BlocProvider.of<HomeLayoutCubit>(context);

          return PopScope(
            canPop: false,

            onPopInvoked: (didPop) {
              if (homeLayoutCubit.selectedIndex == 0) {
                return;
              }
              homeLayoutCubit.returnIndex(context);
            },
            child: Scaffold(
              body: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 300),
                reverse: homeLayoutCubit.selectedIndex <
                    homeLayoutCubit.previousIndex,
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) {
                  Tween<Offset> myTween = Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: const Offset(0, 0),
                  );

                  return SlideTransition(
                    position: myTween.animate(primaryAnimation),
                    child: child,
                  );
                },
                child: homeLayoutCubit.screens[homeLayoutCubit.selectedIndex],
              ),
              bottomNavigationBar: Offstage(
                offstage: homeLayoutCubit.selectedIndex == 3,
                child: Container(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.r),
                    child: GNav(
                      textStyle: Styles.styles12w500sFProTextFamily,
                      selectedIndex: homeLayoutCubit.selectedIndex,
                      padding: EdgeInsets.all(13.r),
                      gap: 8.w,
                      tabBackgroundColor: MyColors.mainColor,
                      onTabChange: (index) {
                        homeLayoutCubit.changeCurrentIndex(context, index);
                      },
                      tabs: [
                        gButtonItem(
                          context: context,
                          activeSvgPath: 'assets/svg_icons/white-home.svg',
                          outlinedSvgPath: 'assets/svg_icons/home.svg',
                          text: 'home',
                          index: 0,
                        ),
                        gButtonItem(
                          context: context,
                          activeSvgPath:
                              'assets/svg_icons/white-search-normal.svg',
                          outlinedSvgPath: 'assets/svg_icons/search-normal.svg',
                          text: 'explore',
                          index: 1,
                        ),
                        gButtonItem(
                          context: context,
                          activeSvgPath: 'assets/svg_icons/white-heart.svg',
                          outlinedSvgPath: 'assets/svg_icons/heart.svg',
                          text: 'liked',
                          index: 2,
                        ),
                        gButtonItem(
                          context: context,
                          activeSvgPath:
                              'assets/svg_icons/white-favorite-Cart.svg',
                          outlinedSvgPath: 'assets/svg_icons/favorite-Cart.svg',
                          text: 'cart',
                          index: 3,
                        ),
                        gButtonItem(
                          context: context,
                          activeSvgPath: 'assets/svg_icons/white-user.svg',
                          outlinedSvgPath: 'assets/svg_icons/user.svg',
                          text: 'profile',
                          index: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
