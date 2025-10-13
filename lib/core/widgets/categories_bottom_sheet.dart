import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/category_builder.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    if (mainCubit.categories.categories?.isEmpty ?? true) {
      mainCubit.getAllCategories(
        homeScreen: false,
      );
    }
    super.initState();
  }

  void getPages(
      ScrollController scrollController, dynamic Function() function) {
    if (scrollController.position.pixels >=
        (scrollController.position.maxScrollExtent - 300)) {
      function();
    }
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
                      scrollController.addListener(() {
                        getPages(scrollController, () {
                          mainCubit.getAllCategories(
                            homeScreen: false,
                          );
                        });
                      });

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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                if (state is FetchMainCubitCategoriesLoading)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 18.w,
                                    ),
                                    child: GridView.builder(
                                      padding: EdgeInsets.only(top: 5.h),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                      itemBuilder: (context, index) =>
                                          Skeletonizer(
                                        child: SizedBox(
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                style: Styles
                                                    .styles11w700interFamily
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
                                if (mainCubit
                                        .categories.categories?.isNotEmpty ??
                                    false)
                                  Expanded(
                                    child: GridView.builder(
                                      controller: scrollController,
                                      padding: EdgeInsets.only(top: 5.h),
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: mainCubit
                                          .categories.categories!.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 125,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent: 135,
                                      ),
                                      itemBuilder: (context, index) =>
                                          categoryBuilder(
                                        islistview: false,
                                        context: context,
                                        category: mainCubit
                                            .categories.categories![index],
                                      ),
                                    ),
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
