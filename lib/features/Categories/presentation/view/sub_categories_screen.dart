import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/sub_categories_notifier.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/cubit/sub_categories_cubit.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view/widgets/custom_appbar.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view/widgets/sub_category_grid.dart';
import 'package:negmt_heliopolis/core/widgets/skeletonizer_loading.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubCategoriesScreen extends StatefulWidget {
  final CategoryModel category;
  const SubCategoriesScreen({super.key, required this.category});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late SubCategoriesCubit subCategoriesCubit;

  final SubCategoriesNotifier notifier = SubCategoriesNotifier();

  final ScrollController _listViewScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();

  List<GlobalKey> listKeys = [];
  List<double> _listHeights = [];
  double sectionBtnWidth = 145;
  List<SubCategories> subCategories = [];
  List<int> subCategoriesIdsList = [];

  @override
  void initState() {
    subCategoriesCubit = BlocProvider.of<SubCategoriesCubit>(context);
    notifier.subCategoriesIds
        .addAll({widget.category.id: subCategoriesIdsList});

    super.initState();
    _scrollController.addListener(_calculateListHeights);
  }

  @override
  void dispose() {
    _listViewScrollController.dispose();
    _scrollController.dispose();

    for (var subCategory in subCategories) {
      notifier.isFetching.remove(subCategory.id);
      notifier.endFetching.remove(subCategory.id);
      notifier.subCategoriesProducts.remove(subCategory.id);
      notifier.subCategoriesIds.remove(subCategory.id);
      subCategoriesCubit.subCategoriesPages.remove(subCategory.id);
    }

    super.dispose();
  }

  void _calculateListHeights() {
    _listHeights = [];

    for (int i = 0; i < listKeys.length; i++) {
      final context = listKeys[i].currentContext;

      if (context != null) {
        final renderToBoxAdapter =
            context.findRenderObject() as RenderSliverToBoxAdapter?;

        if (renderToBoxAdapter != null) {
          _listHeights.add(renderToBoxAdapter.geometry?.scrollExtent ?? 0);
        }
      }
    }

    for (int i = 1; i < _listHeights.length; i++) {
      _listHeights[i] += _listHeights[i - 1];
    }

    _getActiveSection();
  }

  void _getActiveSection() async {
    double scrollPosition = _scrollController.position.pixels;

    for (int i = 0; i < _listHeights.length; i++) {
      if (scrollPosition < _listHeights[i] - 300.h) {
        //
        if (i != notifier.activeSection) {
          notifier.activeSection = i;
          notifier.triggerNotification();
        }

        if ((_listViewScrollController.position.pixels ==
            sectionBtnWidth * notifier.activeSection)) {
          break;
        }

        if (_listViewScrollController.position.pixels ==
                _listViewScrollController.position.maxScrollExtent &&
            sectionBtnWidth * notifier.activeSection >
                _listViewScrollController.position.maxScrollExtent) {
          break;
        }

        await _listViewScrollController.animateTo(
          sectionBtnWidth * notifier.activeSection,
          duration: const Duration(seconds: 1),
          curve: Curves.ease,
        );

        break;
      }
    }

    _checkFetchingMore();
  }

  void _checkFetchingMore() {
    double scrollPosition = _scrollController.position.pixels;
    double screenHeight = MediaQuery.of(context).size.height;

    if ((scrollPosition + screenHeight * 2) >
        _listHeights[notifier.activeSection]) {
      //
      if (!notifier.allowFetch) return;

      int subCategoryId = notifier
          .subCategoriesIds[widget.category.id]![notifier.activeSection];
      subCategoriesCubit.fetchProductsInSubCategory(subCategoryId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCategoriesCubit, SubCategoriesState>(
      listener: (context, state) {
        var subCategroiesCubit = BlocProvider.of<SubCategoriesCubit>(context);

        if (state is GetMainSubCategoriesFailed) {
          CustomSnackBar.show(
            context: context,
            duration: const Duration(seconds: 10),
            text: state.message,
            isGreen: false,
          );
        }

        if (state is GetMainSubCategoriesSuccess) {
          subCategories = state.subCategories;

          for (var subCategory in subCategories) {
            notifier.isFetching.addAll({subCategory.id!: false});
            notifier.endFetching.addAll({subCategory.id!: false});
            subCategroiesCubit.subCategoriesPages.addAll({subCategory.id!: 0});
            notifier.subCategoriesProducts.addAll({subCategory.id!: []});
            subCategoriesIdsList.add(subCategory.id!);

            listKeys.add(GlobalKey());
          }

          for (var subCategory in subCategories) {
            subCategroiesCubit.fetchProductsInSubCategory(
                subCategory.id!, context);
          }
        }
      },
      builder: (context, state) {
        if (subCategories.isNotEmpty) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(150.h),
              child: CustomAppbar(
                categoryName: widget.category.name,
                subCategories: subCategories,
                listKeys: listKeys,
                sectionBtnWidth: sectionBtnWidth,
                listViewScrollController: _listViewScrollController,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(10.r),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // FEATURED
                  // SliverToBoxAdapter(
                  //   child: Container(
                  //     height: 200,
                  //     color: Colors.black,
                  //     margin: EdgeInsets.only(
                  //       top: 40.h,
                  //       bottom: 20.h,
                  //     ),
                  //     child: Text(
                  //       widget.category.name,
                  //       style: TextStyle(
                  //         fontSize: 30.sp,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  ...List.generate(
                    subCategories.length,
                    (index) {
                      var subCategory = subCategories[index];

                      return SubCategoryGrid(
                        globalKey: listKeys[index],
                        index: index,
                        subCategory: subCategory,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        if (state is LoadingMainSubCategories) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(150.h),
              child: Skeletonizer(
                child: CustomAppbar(
                  categoryName: widget.category.name,
                  subCategories: subCategories,
                  listKeys: listKeys,
                  sectionBtnWidth: sectionBtnWidth,
                  listViewScrollController: _listViewScrollController,
                ),
              ),
            ),
            body: Skeletonizer(
              child: gridProductsLoading(9),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
