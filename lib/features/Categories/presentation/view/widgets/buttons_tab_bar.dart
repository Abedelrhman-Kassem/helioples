import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class CustomButtonsTabBar extends StatefulWidget {
  final List<String> subCategories;
  final Function(int) onTap;

  const CustomButtonsTabBar({
    required this.subCategories,
    required this.onTap,
    super.key,
  });

  @override
  CustomButtonsTabBarState createState() => CustomButtonsTabBarState();
}

class CustomButtonsTabBarState extends State<CustomButtonsTabBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.subCategories.length, (index) {
      return AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300));
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
      splashColor: MyColors.mainColor,
      height: 60.h,
      backgroundColor: const Color.fromRGBO(204, 229, 233, 1),
      unselectedBackgroundColor: Colors.white,
      unselectedBorderColor: const Color.fromRGBO(170, 170, 170, 1),
      labelStyle: Styles.styles15w400NormalBlack.copyWith(
        fontWeight: FontWeight.w600,
        color: MyColors.mainColor,
      ),
      borderColor: Colors.transparent,
      borderWidth: 1.sp,
      unselectedLabelStyle: Styles.styles15w400NormalBlack.copyWith(
        fontWeight: FontWeight.w500,
        color: const Color.fromRGBO(150, 150, 150, 1),
      ),
      radius: 30.r,
      buttonMargin: EdgeInsets.all(10.sp),
      contentCenter: true,
      labelSpacing: 10.sp,
      contentPadding: EdgeInsets.all(12.sp),
      onTap: (index) {
        widget.onTap(index);
        // Check if you need to fetch more categories
        if (index == widget.subCategories.length - 1) {
          // Trigger your fetch subcategories logic here
        }
      },
      tabs: [
        ...widget.subCategories.map((subCategory) {
          return Tab(
            icon: Image.asset(
                "assets/Icons_logos/${subCategory.toLowerCase()}.png"), // Adjust the icon path accordingly
            text: subCategory,
          );
        }),
      ],
    );
  }
}
