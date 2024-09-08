import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/category_builder.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/get_all_categories_repo_imp.dart';

Widget categoriesButtonTitleWidet({
  required BuildContext context,
  required title,
}) {




  return TextButton(
    onPressed: () async {
      return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: Styles.styles15w700NormalBlack,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: svgIcon(
                            path: 'assets/svg_icons/x-close.svg',
                            width: 20.w,
                            height: 20.h,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Expanded(
                    //   child: GridView.builder(
                    //     controller:
                    //         scrollController, // Use the controller to sync with the DraggableScrollableSheet
                    //     padding: EdgeInsets.only(top: 5.h),
                    //     physics: const BouncingScrollPhysics(),
                    //     itemCount: 17,
                    //     gridDelegate:
                    //         const SliverGridDelegateWithMaxCrossAxisExtent(
                    //       maxCrossAxisExtent: 125,
                    //       mainAxisSpacing: 10,
                    //       crossAxisSpacing: 10,
                    //       mainAxisExtent: 135,
                    //     ),
                    //     itemBuilder: (context, index) => categoryBuilder(
                    //       context: context,
                    //       category: allCategoriesModel.categories![0],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Styles.styles16w700interFamily,
        ),
        SizedBox(width: 5.w),
        svgIcon(
          path: 'assets/svg_icons/categories_arrow.svg',
          width: 11.w,
          height: 5.5.h,
          color: MyColors.mainColor,
        ),
      ],
    ),
  );
}
