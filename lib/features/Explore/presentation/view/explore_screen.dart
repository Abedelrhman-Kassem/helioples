import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view/widgets/search_delegate.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view/widgets/search_history_widget.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view_model/cubit/explore_cubit.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late HomeLayoutCubit homeLayoutCubit;
  List<String> searchHistoryValues = [];

  @override
  void initState() {
    homeLayoutCubit = BlocProvider.of<HomeLayoutCubit>(context);

    getSearchHistory();

    super.initState();
  }

  void getSearchHistory() {
    DBHelper.queryData(table: searchTable).then((value) {
      searchHistoryValues = [];
      setState(() {
        for (var item in value) {
          searchHistoryValues.add(item[searchItemName] as String);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit(),
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (context, state) {
          if (state is ExploreFailed) {
            if (state.error.isEmpty) {
              return;
            }
            CustomSnackBar.show(
              context: context,
              duration: const Duration(seconds: 10),
              text: state.error,
              isGreen: false,
            );
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
                onTap: () async {
                  await showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(exploreCubit),
                  );

                  getSearchHistory();
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
                        LocaleKeys.search_delegate_search_for_groceries_and_more
                            .tr(),
                        style: Styles.styles14w400Black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.all(15.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.search_delegate_search_history.tr(),
                          style: Styles.styles14w600NormalBlack,
                        ),
                        InkWell(
                          onTap: () async {
                            try {
                              await DBHelper.deleteData(table: searchTable);
                              searchHistoryValues = [];
                              setState(() {});
                            } catch (e) {
                              if (kDebugMode) {
                                print(e.toString());
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            child: Text(
                              LocaleKeys.search_delegate_clear_history.tr(),
                              style: Styles.styles14w400MainColor,
                            ),
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
                          searchHistoryValues.length,
                          (index) {
                            return searchHistoryWidget(
                              context: context,
                              text: searchHistoryValues[index],
                              getSearchHistory: getSearchHistory,
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
