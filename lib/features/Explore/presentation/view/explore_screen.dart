import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget_grid.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view/widgets/search_history_widget.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view_model/cubit/explore_cubit.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeLayoutCubit homeLayoutCubit = BlocProvider.of<HomeLayoutCubit>(context);

    const List<String> history = [
      'Croissant',
      'Kabab Chips',
      "Fresh Tomato's",
      'Rose Beef',
      'Cooking Oil'
    ];

    return BlocProvider(
      create: (context) => ExploreCubit(),
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (context, state) {},
        builder: (context, state) {
          ExploreCubit exploreCubit = BlocProvider.of<ExploreCubit>(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: Container(
                alignment: Alignment.centerRight,
                child: returnArrow(
                  context: context,
                  onTap: () {
                    homeLayoutCubit.returnIndex(context);
                  },
                ),
              ),
              titleSpacing: 0,
              actions: [SizedBox(width: 25.r)],
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(239, 239, 239, 1),
                  borderRadius: BorderRadius.circular(33.06.r),
                ),
                child: TextField(
                  controller: exploreCubit.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for groceries and more',
                    border: InputBorder.none,
                    hintStyle: Styles.styles14w400Black,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: svgIcon(
                        path: 'assets/svg_icons/search-normal.svg',
                        width: 26.44.w,
                        height: 26.44.h,
                        color: MyColors.mainColor,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxWidth: 31.44.w,
                      maxHeight: 31.44.h,
                    ),
                  ),
                  cursorColor: MyColors.mainColor,
                  style: Styles.styles14w400MainColor,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      exploreCubit.changeSearchExplore(value.trim());
                    }
                  },
                ),
              ),
            ),
            body: Container(
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.all(15.r),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: exploreCubit.canSearch
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Search Results Of',
                                    style: Styles.styles14w400NormalBlack,
                                  ),
                                  Text(
                                    exploreCubit.searchController.text,
                                    style: Styles.styles26w600NormalBlack,
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 174, 198, 0.1),
                                  borderRadius: BorderRadius.circular(33.06.r),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: '${history.length} ',
                                    style: Styles.styles14w700MainColor,
                                    children: [
                                      TextSpan(
                                        text: 'Products',
                                        style: Styles.styles14w400MainColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          itemWidgetGridView(),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Search History',
                                style: Styles.styles14w600NormalBlack,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'Clear History',
                                  style: Styles.styles14w400MainColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: List.generate(
                                5,
                                (index) {
                                  return searchHistoryWidget(
                                    context,
                                    history[index],
                                  );
                                },
                              ),
                            ),
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
