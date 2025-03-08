import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view_model/cubit/explore_cubit.dart';
import 'package:negmt_heliopolis/core/widgets/skeletonizer_loading.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final ExploreCubit exploreCubit;
  final String? historyValue;

  CustomSearchDelegate(this.exploreCubit, {this.historyValue});

  @override
  String? get searchFieldLabel => 'Search for groceries and more';

  @override
  TextStyle? get searchFieldStyle => Styles.styles14w400NormalBlack;

  @override
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
        fillColor: const Color.fromRGBO(239, 239, 239, 1),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(33.r),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(33.r),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(33.r),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return returnArrow(
      context: context,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ScrollController scrollController = ScrollController();
    int page = 0;
    bool isLoading = false;
    bool endFetching = false;

    void getPages() {
      if (isLoading || endFetching) return;

      if (query.trim().length <= 2) return;

      if (scrollController.position.pixels >=
          (scrollController.position.maxScrollExtent - 300)) {
        exploreCubit.search(query, page);
      }
    }

    scrollController.addListener(getPages);

    List<RelatedProductsModel> products = [];
    if (query.trim().length > 2) {
      exploreCubit.search(query, page);
      exploreCubit.insertSearchDbData(query.trim());
    }

    @override
    dispose() {
      scrollController.removeListener(getPages);
      scrollController.dispose();
      super.dispose();
    }

    return BlocProvider.value(
      value: exploreCubit,
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (context, state) {
          if (state is ExploreLoading) {
            isLoading = true;
          }

          if (state is ExploreSuccess || state is ExploreFailed) {
            isLoading = false;
          }

          if (state is ExploreSuccess) {
            if (state.searchModel.products!.isEmpty) {
              endFetching = true;
            } else {
              products.addAll(state.searchModel.products!);
              page++;
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                if (state is ExploreLoading && products.isEmpty)
                  gridProductsLoading(9),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 220,
                    ),
                    itemBuilder: (context, index) => ItemWidget(
                      key: ValueKey(products[index].id),
                      relatedProductsModel: products[index],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (historyValue != null) {
      query = historyValue!;
    }

    List<RelatedProductsModel> products = [];
    if (query.trim().length > 2) {
      exploreCubit.search(query, 0);
    }

    return BlocProvider.value(
      value: exploreCubit,
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (context, state) {
          if (state is ExploreSuccess) {
            products = state.searchModel.products!;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  showResults(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 20.w,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  width: double.infinity,
                  color: const Color.fromRGBO(239, 239, 239, 1),
                  child: Text(
                    'All Suggestions',
                    style: Styles.styles12w400black,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) => InkWell(
                      key: ValueKey(products[index].id),
                      onTap: () {
                        Navigator.pushNamed(context, productScreen, arguments: {
                          'productId': products[index].id,
                        });
                      },
                      child: Container(
                        height: 40.h,
                        margin: EdgeInsets.symmetric(
                          vertical: 10.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Helper.loadNetworkImage(
                              url: products[index].thumbnailImage ?? '',
                              assetsErrorPath:
                                  'assets/Icons_logos/Butter Croissant_2.png',
                              fit: BoxFit.contain,
                              width: 50.w,
                            ),
                            SizedBox(width: 20.w),
                            Text(
                              products[index].name!,
                              style: Styles.styles12w400black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
