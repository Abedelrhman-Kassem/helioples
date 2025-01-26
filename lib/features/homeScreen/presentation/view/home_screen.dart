import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/core/widgets/category_builder.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/widgets/loading_offer_wiget.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/widgets/location_widget.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeLayoutCubit homeLayoutCubit;

  @override
  void initState() {
    homeLayoutCubit = BlocProvider.of<HomeLayoutCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAr = isRtl(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
              listener: (context, state) {
                if (state is FetchConfigsLoading ||
                    state is FetchConfigsFailed) {
                  homeLayoutCubit.gettingConfigs = false;
                }

                if (state is FetchConfigsFailed) {
                  CustomSnackBar.show(
                    context: context,
                    duration: const Duration(seconds: 10),
                    text: state.error,
                    isGreen: false,
                  );
                }

                if (state is FetchConfigsSuccess) {
                  homeLayoutCubit.configs =
                      state.homeSliderModel.configs!.homeScreenSlider!;
                  homeLayoutCubit.gettingConfigs = true;
                }
              },
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    if (homeLayoutCubit.gettingConfigs)
                      CarouselSlider(
                        items: homeLayoutCubit.configs.map(
                          (ele) {
                            return SizedBox(
                              child: Helper.loadNetworkImage(
                                url: ele,
                                assetsErrorPath: 'assets/test_images/home.png',
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          aspectRatio: 438 / 424,
                          // height: 430.h,
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
                    if (!homeLayoutCubit.gettingConfigs)
                      Skeletonizer(
                        child: AspectRatio(
                          aspectRatio: 438 / 424,
                          child: Helper.loadNetworkImage(
                            assetsErrorPath: 'assets/test_images/home.png',
                          ),
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
                            homeLayoutCubit.changeCurrentIndex(context, 1);
                          },
                          icon: svgIcon(
                            path: 'assets/svg_icons/search-normal.svg',
                            width: 26.44.w,
                            height: 26.44.h,
                            color: MyColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            BlocConsumer<MainCubit, MainState>(
              listener: (context, state) {
                if (state is GetAddressesFailed) {
                  CustomSnackBar.show(
                    context: context,
                    duration: const Duration(seconds: 10),
                    text: state.error,
                    isGreen: false,
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadingAddresses) {
                  return FractionalTranslation(
                    translation: const Offset(0, -0.5),
                    child: Skeletonizer(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.w,
                            vertical: 10.h,
                          ),
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('hello there how are you'),
                              Text('hello there how are you'),
                            ],
                          )),
                    ),
                  );
                } else if (state is GetAddressesSuccessfully) {
                  return FractionalTranslation(
                    translation: const Offset(0, -0.5),
                    child: LocationWidget(addressModel: state.addressModel),
                  );
                } else {
                  return SizedBox(
                    height: 50.h,
                  );
                }
              },
            ),
            Column(
              children: [
                // Special Offers -----------------------------------------------
                BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
                  listener: (context, state) {
                    if (state is FetchOffersLoading ||
                        state is FetchOffersFailed) {
                      homeLayoutCubit.gettingOffers = false;
                    }

                    if (state is FetchOffersFailed) {
                      CustomSnackBar.show(
                        context: context,
                        duration: const Duration(seconds: 10),
                        text: state.error,
                        isGreen: false,
                      );
                    }

                    if (state is FetchOffersSuccess) {
                      homeLayoutCubit.offers = state.specialOfferModel.offers!;
                      homeLayoutCubit.gettingOffers = true;
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (homeLayoutCubit.gettingOffers) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Special Offers',
                                  style: Styles.styles17w600interFamily,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      allspecialOffersScreen,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'View All',
                                        style: Styles.styles14w500interFamily,
                                      ),
                                      SizedBox(width: 4.w),
                                      Transform(
                                        transform:
                                            Matrix4.rotationY(isAr ? pi : 0),
                                        child: svgIcon(
                                          path:
                                              'assets/svg_icons/arrow-right.svg',
                                          width: 10,
                                          height: 9,
                                          color: const Color.fromRGBO(
                                              0, 126, 143, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 18.w),
                            child: AspectRatio(
                              aspectRatio: 297 / 140,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: homeLayoutCubit.offers.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: 275.w,
                                    child: SpecialOfferWidget(
                                      offer: homeLayoutCubit.offers[index],
                                      canNavigate: true,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 20.w),
                              ),
                            ),
                          ),
                        ],
                        if (!homeLayoutCubit.gettingOffers)
                          const LoadingOfferWiget(),
                      ],
                    );
                  },
                ),
                // Categories ---------------------------------------------------
                BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
                  listener: (context, state) {
                    if (state is FetchCategoriesSuccess) {
                      homeLayoutCubit.gettingCategories = true;
                      homeLayoutCubit.categories = state.categories.categories!;
                    }

                    if (state is FetchCategoriesFailure) {
                      CustomSnackBar.show(
                        context: context,
                        duration: const Duration(seconds: 10),
                        text: state.error,
                        isGreen: false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Categories',
                                style: Styles.styles17w600interFamily,
                              ),
                              IconButton(
                                icon: SizedBox.square(
                                  dimension: 36.r,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 1.r,
                                      vertical: 0.r,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                        237,
                                        237,
                                        237,
                                        1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.r),
                                      ),
                                      boxShadow: [
                                        MyBoxShadows.iconsIsCategoryBoxShadow
                                      ],
                                    ),
                                    child: homeLayoutCubit.isCategoryRow
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
                                                  width: 8.w,
                                                  height: 8.h,
                                                  color: MyColors.mainColor,
                                                );
                                              },
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              2,
                                              (rowIndex) => Padding(
                                                padding: EdgeInsets.only(
                                                  bottom:
                                                      rowIndex < 1 ? 1.h : 0,
                                                ), // Add space between rows
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: List.generate(
                                                    2,
                                                    (colIndex) => Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 1
                                                              .w), // Adjust horizontal spacing between icons
                                                      child: svgIcon(
                                                        path:
                                                            'assets/svg_icons/square-category.svg',
                                                        width: 8.w,
                                                        height: 8.h,
                                                        color:
                                                            MyColors.mainColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                onPressed: () {
                                  homeLayoutCubit.changeCategory();
                                },
                              ),
                            ],
                          ),
                        ),
                        if (homeLayoutCubit.gettingCategories == true)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            reverseDuration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: homeLayoutCubit.isCategoryRow
                                ? Container(
                                    padding:
                                        EdgeInsetsDirectional.only(start: 18.w),
                                    height: 200,
                                    child: ListView.separated(
                                      padding: EdgeInsets.only(top: 5.h),
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          categoryBuilder(
                                        context: context,
                                        category:
                                            homeLayoutCubit.categories[index],
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(width: 14),
                                      itemCount:
                                          homeLayoutCubit.categories.length,
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 18.w,
                                    ),
                                    child: GridView.builder(
                                      padding: EdgeInsets.only(top: 5.h),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          homeLayoutCubit.categories.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 125,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        // childAspectRatio: 1 / 1.5,
                                        mainAxisExtent: 135,
                                      ),
                                      itemBuilder: (context, index) =>
                                          categoryBuilder(
                                        context: context,
                                        category:
                                            homeLayoutCubit.categories[index],
                                      ),
                                    ),
                                  ),
                          )
                        else
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.w,
                            ),
                            child: GridView.builder(
                              padding: EdgeInsets.only(top: 5.h),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 9,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 125,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                // childAspectRatio: 1 / 1.5,
                                mainAxisExtent: 135,
                              ),
                              itemBuilder: (context, index) => Skeletonizer(
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                        ),
                                        child: Helper.loadNetworkImage(
                                          assetsErrorPath:
                                              'assets/screens_background/home-category.png',
                                        ),
                                      ),
                                      Text(
                                        'hello how',
                                        style: Styles.styles11w700interFamily
                                            .copyWith(fontSize: 11),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
