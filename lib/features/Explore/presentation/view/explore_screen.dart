import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget_grid.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view/widgets/search_delegate.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view/widgets/search_history_widget.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view_model/cubit/explore_cubit.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeLayoutCubit homeLayoutCubit = BlocProvider.of<HomeLayoutCubit>(context);
    List<RelatedProductsModel> products = [];

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
        listener: (context, state) {
          if (state is ExploreFailed) {
            CustomSnackBar.show(
              context: context,
              duration: const Duration(seconds: 10),
              text: state.error,
              isGreen: false,
            );
          }

          if (state is ExploreSuccess) {
            products = state.searchModel.products!;
          }
        },
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
              actions: [
                SizedBox(width: 20.w),
              ],
              title: InkWell(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(exploreCubit),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 10.w,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 239, 239, 1),
                    borderRadius: BorderRadius.circular(33.06.r),
                  ),
                  child: Row(
                    children: [
                      svgIcon(
                        path: 'assets/svg_icons/search-normal.svg',
                        width: 26.44.w,
                        height: 26.44.h,
                        color: MyColors.mainColor,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'Search for groceries and more',
                        style: Styles.styles14w400Black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // body: Container(
            //   margin: EdgeInsets.only(top: 10.h),
            //   padding: EdgeInsets.all(15.r),
            //   child: SingleChildScrollView(
            //     physics: const BouncingScrollPhysics(),
            //     child: Column(
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               'Search History',
            //               style: Styles.styles14w600NormalBlack,
            //             ),
            //             InkWell(
            //               onTap: () {},
            //               child: Text(
            //                 'Clear History',
            //                 style: Styles.styles14w400MainColor,
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 20.h),
            //         SizedBox(
            //           width: double.infinity,
            //           child: Wrap(
            //             spacing: 10.w,
            //             runSpacing: 10.h,
            //             children: List.generate(
            //               5,
            //               (index) {
            //                 return searchHistoryWidget(
            //                   context,
            //                   history[index],
            //                 );
            //               },
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
