import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/sub_categories_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/cubit/sub_categories_cubit.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view/widgets/custom_appbar.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view/widgets/featuer_widget.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view/widgets/sub_category_grid.dart';
import 'package:negmt_heliopolis/core/widgets/skeletonizer_loading.dart';

import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/featur_model.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/core/widgets/pagination_listener.dart';

class SubCategoriesScreen extends StatefulWidget {
  final CategoryModel? category;
  final String categoryId;
  const SubCategoriesScreen({
    super.key,
    this.category,
    required this.categoryId,
  });

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late SubCategoriesCubit subCategoriesCubit;
  CategoryModel? currentCategory;

  final SubCategoriesNotifier notifier = SubCategoriesNotifier();

  final ScrollController _listViewScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();

  List<GlobalKey> listKeys = [];
  List<double> _listHeights = [];
  double sectionBtnWidth = 145;
  List<SubCatByCatidData> subCategories = [];
  List<FeaturData> features = [];
  List<String> subCategoriesIdsList = [];

  @override
  void initState() {
    subCategoriesCubit = BlocProvider.of<SubCategoriesCubit>(context);
    currentCategory = widget.category;
    notifier.subCategoriesIds.addAll({widget.categoryId: subCategoriesIdsList});

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

    if (currentCategory != null) {
      notifier.subCategoriesIds.remove(currentCategory!.id);
    }

    for (var feature in features) {
      if (feature.id != null) {
        notifier.isFetching.remove(feature.id);
        notifier.endFetching.remove(feature.id);
        notifier.productsFeatured.remove(feature.id);
        subCategoriesCubit.productsFeaturedPages.remove(feature.id);
      }
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

        if (mounted) {
          await _listViewScrollController.animateTo(
            sectionBtnWidth * notifier.activeSection,
            duration: const Duration(seconds: 1),
            curve: Curves.ease,
          );
        }

        break;
      }
    }

    if (!mounted) return;

    _checkFetchingMore();
  }

  void _checkFetchingMore() {
    if (!_scrollController.hasClients) return;
    double scrollPosition = _scrollController.position.pixels;
    double screenHeight = MediaQuery.of(context).size.height;

    if ((scrollPosition + screenHeight * 2) >
        _listHeights[notifier.activeSection]) {
      //
      if (!notifier.allowFetch) return;

      // If features exist and we're on the featured section, don't fetch subcategory products
      if (features.isNotEmpty && notifier.activeSection == 0) return;

      log("fetching more");
      // Adjust index if features exist (because listKeys[0] is for features)
      int subCategoryIndex = features.isNotEmpty
          ? notifier.activeSection - 1
          : notifier.activeSection;

      String subCategoryId =
          notifier.subCategoriesIds[widget.categoryId]![subCategoryIndex];
      subCategoriesCubit.fetchProductsInSubCategory(subCategoryId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCategoriesCubit, SubCategoriesState>(
      listener: (context, state) {
        var subCategroiesCubit = BlocProvider.of<SubCategoriesCubit>(context);

        if (state is GetMainSubCategoriesSuccess) {
          log("state: ${state.subCategories}");
          subCategories = state.subCategories;
          features = state.features;
          currentCategory = state.category;

          listKeys.clear();
          if (features.isNotEmpty) {
            listKeys.add(GlobalKey());
          }

          for (var subCategory in subCategories) {
            notifier.isFetching.addAll({subCategory.id!: false});
            notifier.endFetching.addAll({subCategory.id!: false});
            subCategroiesCubit.subCategoriesPages.addAll({subCategory.id!: 0});
            notifier.subCategoriesProducts.addAll({subCategory.id!: []});
            subCategoriesIdsList.add(subCategory.id!);

            listKeys.add(GlobalKey());
          }
        }
      },
      builder: (context, state) {
        // Show loading if we are loading main categories OR features (only if no content yet)
        // Show loading if we are loading main categories
        if (state is LoadingMainSubCategories || currentCategory == null) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(150.h),
              child: Skeletonizer(
                child: CustomAppbar(
                  categoryName: currentCategory?.name ?? "Loading...",
                  subCategories: subCategories,
                  listKeys: listKeys,
                  sectionBtnWidth: sectionBtnWidth,
                  listViewScrollController: _listViewScrollController,
                  showFeatured: features.isNotEmpty,
                ),
              ),
            ),
            body: Skeletonizer(child: gridProductsLoading(9)),
          );
        }

        // Show content if main categories are loaded OR if we have data and state is something else (like features success/loading)
        if (state is GetMainSubCategoriesSuccess ||
            (subCategories.isNotEmpty && currentCategory != null)) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(150.h),
              child: CustomAppbar(
                categoryName: currentCategory!.name!,
                subCategories: subCategories,
                listKeys: listKeys,
                sectionBtnWidth: sectionBtnWidth,
                listViewScrollController: _listViewScrollController,
                showFeatured: features.isNotEmpty,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(10.r),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // FEATURED
                  FeaturedProductsWidget(
                    key: features.isNotEmpty ? listKeys[0] : null,
                    features: features,
                    subCategoriesCubit: subCategoriesCubit,
                  ),
                  ...List.generate(subCategories.length, (index) {
                    var subCategory = subCategories[index];
                    int keyIndex = index + (features.isNotEmpty ? 1 : 0);

                    return SubCategoryGrid(
                      globalKey: listKeys[keyIndex],
                      index: index,
                      subCategory: subCategory,
                    );
                  }),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
