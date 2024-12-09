import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/categories_button_title_widget.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo_imp.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/sub_categories_cubit.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/sub_categories_states.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesScreen extends StatefulWidget {
  final CategoryModel category;
  const CategoriesScreen({super.key, required this.category});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  List<String> categories = [];
  List<String> images = [
    'assets/svg_icons/noto_crown.svg',
    'assets/svg_icons/noto_crown.svg',
    'assets/svg_icons/noto_crown.svg',
    'assets/svg_icons/noto_crown.svg',
  ];
  String crownImage = 'assets/svg_icons/noto_crown.svg';

  List<GlobalKey> sectionKeys = [];

  List<int> itemsCount = [5, 5, 5, 5];
  late ScrollController scrollController;
  BuildContext? tabContext;
  late SubCategoriesCubit subCategoriesCubit;

  final Set<int> loadedSubCategories = {};
  late TabController tabController;
  int x = 1;
   int? firstSubCategoryId ; 

  @override
 @override
void initState() {
  super.initState();
  tabController = TabController(length: 1, vsync: this);
  scrollController = ScrollController();
  scrollController.addListener(_handleScroll);
  subCategoriesCubit = SubCategoriesCubit(SubCategoriesRepoImp(api: ApiService()));

  Future.microtask(() async {
    await _initializeSubCategories();
  });
}


  Future<void> _initializeSubCategories() async {
    await subCategoriesCubit.fetchSubCategories(widget.category.id);
    final subCategoryIds = subCategoriesCubit.subCategoryProducts.keys.toList();
    if (subCategoryIds.isNotEmpty) {
       firstSubCategoryId = subCategoryIds.first;
      loadedSubCategories.add(firstSubCategoryId!);


    }

    final subCategoryCount = subCategoriesCubit.subCategoryProducts.keys.length;
    sectionKeys = List.generate(subCategoryCount, (_) => GlobalKey());
  }

  @override
  void dispose() {
    scrollController.dispose();
    subCategoriesCubit.close();
    super.dispose();
  }

  bool isLoading = false;

  void _handleScroll() {
    final screenHeight = MediaQuery.of(context).size.height;

    for (int i = 0; i < sectionKeys.length; i++) {
      final RenderBox? box =
          sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;

      if (box != null) {
        final position = box.localToGlobal(Offset(0, box.size.height));

        if (position.dy <= box.size.height + screenHeight / 8 &&
            position.dy > screenHeight / 8) {
          int subCategoryId =
              subCategoriesCubit.subCategoryProducts.keys.elementAt(i); //
          if (!isLoading) {
            isLoading = true;

            subCategoriesCubit.fetchProductsInSubCategory(subCategoryId,
                isPagination: true); //

            isLoading = false;

            setState(() {});
          }
        }
        DefaultTabController.of(tabContext!).animateTo(i);
        break;
      }
    }
  }

  void _scrollToSection(int index) {
    // Delay the scroll action until the current frame is done laying out the widgets.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.removeListener(_handleScroll);
      final context = sectionKeys[index].currentContext!;
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
      ).then((_) {
        scrollController.addListener(_handleScroll);
      });
    });
  }

void _handleScroll() {
  for (int i = 0; i < sectionKeys.length; i++) {
    final RenderBox? box =
        sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;
    if (box == null) continue;

    final position = box.localToGlobal(Offset.zero);
    final isVisible = position.dy >= 0 && position.dy < MediaQuery.of(context).size.height;

    if (isVisible) {
      final subCategoryId = subCategoriesCubit.subCategoryProducts.keys.elementAt(i);

      // Lazy load subcategory products if not already loaded
      if (loadedSubCategories.add(subCategoryId)) {
        subCategoriesCubit.fetchAllPRoductsOfSubCategory(subCategoryId);
      }

      // Handle tab animation

      setState(() {
           DefaultTabController.of(tabContext!).animateTo(i);
        
      });
 


      // Prefetch the next subcategory
      if (i + 1 < sectionKeys.length) {
        final nextSubCategoryId = subCategoriesCubit.subCategoryProducts.keys.elementAt(i + 1);
        if (loadedSubCategories.add(nextSubCategoryId)) {
          subCategoriesCubit.fetchAllPRoductsOfSubCategory(nextSubCategoryId);
        }
      }
      break;
    }
  }
}





void _scrollToSection(int index) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    scrollController.removeListener(_handleScroll);

    final subCategoryId = subCategoriesCubit.subCategoryProducts.keys.elementAt(index);

    if (!loadedSubCategories.contains(subCategoryId)) {
      setState(() {
        loadedSubCategories.add(subCategoryId);
      });

      await subCategoriesCubit.fetchAllPRoductsOfSubCategory(subCategoryId);
    }

    final context = sectionKeys[index].currentContext;

    if (context == null) {
      log("Section key at index $index has no attached context.");
      return; // Avoid performing actions on a null context
    }

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0,
    ).then((_) {
      scrollController.addListener(_handleScroll);
    });

    // Fetch DefaultTabController safely
    final tabController = DefaultTabController.of(context);
    if (tabController != null) {
      tabController.animateTo(index);
    } else {
      log("DefaultTabController is null when animating to index $index.");
    }
  });
}


Future<void> _loadRemainingDataForCurrentTab() async {
  final currentSubCategoryId = subCategoriesCubit.subCategoryProducts.keys.first;

  if (subCategoriesCubit.hasMore[currentSubCategoryId] == true) {
    await subCategoriesCubit.fetchProductsInSubCategory(currentSubCategoryId, isPagination: true);
  }
}




  @override
  @override
Widget build(BuildContext context) {
  return BlocProvider<SubCategoriesCubit>.value(
    value: subCategoriesCubit,
    child: BlocBuilder<SubCategoriesCubit, FetchCategoriesState>(
      builder: (context, state) {
        if (state is SubCategoriesLoading) {
          return _buildLoadingState();
        } else if (state is SubCategoriesFailure) {
          return _buildErrorState(state.message);
        } else if (state is SubCategoriesSuccess ||
            state is ProductsLoading ||
            state is ProductsSuccess) {
          return _buildCategoriesContent(state);
        }
        return Container();
      },
    ),
  );
}

Widget _buildLoadingState() {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    controller: scrollController,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildShimmerLoading2(tabController)],
    ),
  );
}

Widget _buildErrorState(String message) {
  return Center(child: Text(message));
}

Widget _buildCategoriesContent(FetchCategoriesState state) {
  categories = state is SubCategoriesSuccess
      ? state.subCategories.map((subCat) => subCat.name ?? "").toList()
      : categories;

  if (categories.isEmpty) {
    return const Center(child: Text("No categories available"));
  }

  return DefaultTabController(


    length: categories.length,
    child: Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  categories.length,
                  (index) => _buildSubCategorySection(index),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: CartContainer(),
          ),
        ],
      ),
    ),
  );
}

PreferredSizeWidget _buildAppBar() {
  
  return PreferredSize(
    preferredSize: Size.fromHeight(180.h),
    
    child: Builder(
      builder: (context) {
        tabContext = context ;
        return AppBar(
          toolbarHeight: 200.h,
          elevation: 20,
          backgroundColor: Colors.white,
          leading: returnArrow(
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: categoriesButtonTitleWidet(
            context: context,
            title: widget.category.name,
          ),
          actions: const [CartCounter()],
          bottom: ButtonsTabBar(
            splashColor: MyColors.mainColor,
            height: 75.h,
            backgroundColor: const Color.fromRGBO(204, 229, 233, 1),
            unselectedBackgroundColor: Colors.white,
            unselectedBorderColor: const Color.fromRGBO(170, 170, 170, 1),
            labelStyle: Styles.styles15w400NormalBlack.copyWith(
              fontWeight: FontWeight.w600,
              color: MyColors.mainColor,
            ),
            borderColor: Colors.transparent,
            borderWidth: 1.sp,
            unselectedLabelStyle: Styles.styles15w400NormalBlack.copyWith(
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(150, 150, 150, 1),
            ),
            radius: 30.r,
            buttonMargin: EdgeInsets.all(10.sp),
            contentCenter: true,
            labelSpacing: 10.sp,
            contentPadding: EdgeInsets.all(12.sp),
            onTap: (index) => _scrollToSection(index),
            tabs: List.generate(
              categories.length,
              (index) => Tab(
                icon: Image.asset("assets/Icons_logos/Donuts.png"),
                text: categories[index],
              ),
            ),
          ),
        );
      }
    ),
  );
}

Widget _buildSubCategorySection(int index) {

  final subCategoryId = subCategoriesCubit.subCategoryProducts.keys.elementAt(index);
 if (subCategoryId == firstSubCategoryId)
 {
   subCategoriesCubit.fetchAllPRoductsOfSubCategory(subCategoryId);
   log("inside condition");
   firstSubCategoryId = 0 ; 
 }
  final products = subCategoriesCubit.subCategoryProducts[subCategoryId] ?? [];

  return Column(
    key: sectionKeys[index],
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        categories[index],
        style: Styles.styles21w700black,
      ),
      SizedBox(height: 16.h),
      if (products.isNotEmpty)
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
            mainAxisExtent: 220,
          ),
          itemBuilder: (context, productIndex) =>
              ItemWidget(relatedProductsModel: products[productIndex]),
        )
      else
        buildItemsShimmer(),
      SizedBox(height: 60.h),
    ],
  );
}

}

Widget buildShimmerLoading() {
  return Container(
    color: Colors.white,
    width: double.infinity,
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120.h,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 70.h,
          ),
          ...List.generate(2, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30.h,
                    width: 100.w,
                    color: Colors.grey[300], // Placeholder for category title
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 160.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                      Container(
                        height: 160.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                      Container(
                        height: 160.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 160.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                      Container(
                        height: 160.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                      Container(
                        height: 160.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 160.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                      Container(
                        height: 160.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                      Container(
                        height: 160.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            );
          }),
          SizedBox(height: 16.h),
          SizedBox(height: 16.h),
        ],
      ),
    ),
  );
}

Widget buildItemsShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 240.h,
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.r)),
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
              height: 240.h,
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.r)),
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
              height: 240.h,
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.r)),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Container(
              height: 240.h,
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.r)),
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
              height: 240.h,
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.r)),
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
              height: 240.h,
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.r)),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Container(
              height: 240.h,
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.r)),
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
              height: 240.h,
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.r)),
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
              height: 240.h,
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.r)),
            ),
          ],
        ),
        SizedBox(height: 30.h),
      ],
    ),
  );
}

Widget buildShimmerLoading2(TabController tabController) {
  return Skeletonizer(
    child: Container(
      color: Colors.white,
      child: Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(110.h),
            child: AppBar(
              toolbarHeight: 100.h,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: const Icon(Icons.add_ic_call_outlined),
              title: const Text("dummy"),
              actions: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add_ic_call_outlined),
                )
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          ...List.generate(
            2,
            (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30.h,
                      width: 100.w,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Container(
                          height: 240.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          height: 240.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          height: 240.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 240.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          height: 240.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          height: 240.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 240.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          height: 240.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          height: 240.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

class SlowScrollPhysics extends ClampingScrollPhysics {
  final double speedFactor;

  SlowScrollPhysics({this.speedFactor = 0.2, ScrollPhysics? parent})
      : super(parent: parent);

  @override
  SlowScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SlowScrollPhysics(
      speedFactor: speedFactor,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // تقليل السرعة بضربها في عامل التباطؤ
    return super.applyPhysicsToUserOffset(position, offset * speedFactor);
  }
}
