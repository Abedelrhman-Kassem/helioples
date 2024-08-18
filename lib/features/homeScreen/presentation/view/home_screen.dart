import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/SvgAsset.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/widgets/category_builder.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/widgets/location_widget.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/widgets/special_offer_widget.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view_model/cubit/home_screen_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit(),
      child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeScreenCubit homeScreenCubit =
              BlocProvider.of<HomeScreenCubit>(context);

          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        items: [1, 2, 3, 4, 5].map(
                          (ele) {
                            return const SizedBox(
                              child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/test_images/home.png',
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          height: 422.h,
                          autoPlay: true,
                          initialPage: 0,
                          viewportFraction: 1,
                          enableInfiniteScroll: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Positioned(
                        top: 63.h,
                        left: 358.w,
                        child: Container(
                          width: 54.w,
                          height: 54.h,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              BlocProvider.of<HomeLayoutCubit>(context)
                                  .changeCurrentIndex(1);
                            },
                            icon: svgIcon(
                              path: 'assets/svg_icons/search-normal.svg',
                              width: 30.w,
                              height: 30.h,
                              color: MyColors.mainColor,
                            ),
                          ),
                        ),
                      ),
                      locationWidget(),
                    ],
                  ),
                  SizedBox(height: 70.h),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(18.0.r),
                        child: Row(
                          children: [
                            Text(
                              'Special Offers',
                              style: Styles.styles17w600interFamily,
                            ),
                            const Spacer(),
                            Text(
                              'View All',
                              style: Styles.styles14w500interFamily,
                            ),
                            SizedBox(width: 4.w),
                            svgIcon(
                              path: 'assets/svg_icons/arrow-right.svg',
                              width: 10,
                              height: 9,
                              color: const Color.fromRGBO(0, 126, 143, 1),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 18.w),
                        child: SizedBox(
                          height: 180.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                specialOfferWidget(),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 20.w),
                            itemCount: 10,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Categories',
                                  style: Styles.styles17w600interFamily,
                                ),
                                IconButton(
                                  icon: Container(
                                    width: 36.w,
                                    height: 36.h,
                                    padding: EdgeInsets.all(1.r),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          237, 237, 237, 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.r),
                                      ),
                                      boxShadow: [
                                        MyBoxShadows.iconsIsCategoryBoxShadow
                                      ],
                                    ),
                                    child: homeScreenCubit.isCategoryRow
                                        ? Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              3,
                                              (index) {
                                                return svgIcon(
                                                  path:
                                                      'assets/svg_icons/square-category.svg',
                                                  width: 12.w,
                                                  height: 12.h,
                                                  color: MyColors.mainColor,
                                                );
                                              },
                                            ),
                                          )
                                        : Wrap(
                                            alignment: WrapAlignment.center,
                                            runAlignment: WrapAlignment.center,
                                            spacing: 2.r,
                                            runSpacing: 2.r,
                                            children: List.generate(
                                              4,
                                              (index) {
                                                return SizedBox(
                                                  child: svgIcon(
                                                    path:
                                                        'assets/svg_icons/square-category.svg',
                                                    width: 12.w,
                                                    height: 12.h,
                                                    color: MyColors.mainColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                  ),
                                  onPressed: () {
                                    homeScreenCubit.changeCategory();
                                  },
                                ),
                              ],
                            ),
                            homeScreenCubit.isCategoryRow
                                ? SizedBox(
                                    height: 200,
                                    child: ListView.separated(
                                      padding: EdgeInsets.only(top: 30.h),
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, state) =>
                                          categoryBuilder(),
                                      separatorBuilder: (context, state) =>
                                          const SizedBox(width: 14),
                                      itemCount: 17,
                                    ),
                                  )
                                : GridView.builder(
                                    padding: EdgeInsets.only(top: 30.h),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 17,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 124,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 1 / 1.4,
                                    ),
                                    itemBuilder: (context, index) =>
                                        categoryBuilder(),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
