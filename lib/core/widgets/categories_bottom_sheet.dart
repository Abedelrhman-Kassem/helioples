import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/services/scroll_pagination_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/widget_category_botton_sheet.dart/gategory_widget.dart';
import 'package:negmt_heliopolis/core/widgets/widget_category_botton_sheet.dart/head_category.dart';
import 'package:negmt_heliopolis/core/widgets/widget_category_botton_sheet.dart/loading_category.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class CategoriesBottomSheet extends StatefulWidget {
  final String title;
  const CategoriesBottomSheet({super.key, required this.title});

  @override
  State<CategoriesBottomSheet> createState() => _CategoriesBottomSheetState();
}

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet> {
  late MainCubit mainCubit;

  @override
  void initState() {
    mainCubit = BlocProvider.of<MainCubit>(context);
    Future.delayed(const Duration(seconds: 2), () {
      if (mainCubit.categories.isEmpty) {
        mainCubit.getAllCategories();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.title.isEmpty
        ? const SizedBox()
        : TextButton(
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
                      ScrollPaginationService.addPaginationListener(
                        scrollController: scrollController,
                        onLoadMore: () => mainCubit.getAllCategories(),
                        isLoading: () => mainCubit.loadingCategories,
                      );

                      return BlocConsumer<MainCubit, MainState>(
                        listener: (context, state) {
                          if (state is FetchMainCubitCategoriesFailure) {
                            CustomSnackBar.show(
                              context: context,
                              duration: const Duration(seconds: 10),
                              text: state.error,
                              isGreen: false,
                            );
                          }
                        },
                        builder: (context, state) {
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
                                const HeadCategory(),
                                SizedBox(height: 20.h),
                                // Show initial loading skeleton only when no categories exist
                                if (state is FetchMainCubitCategoriesLoading &&
                                    mainCubit.categories.isEmpty)
                                  const LoadingCategory(),
                                // Show categories when available
                                if (mainCubit.categories.isNotEmpty)
                                  GategoryWidget(
                                    scrollController: scrollController,
                                    mainCubit: mainCubit,
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: Styles.styles16w700interFamily,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
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
}
