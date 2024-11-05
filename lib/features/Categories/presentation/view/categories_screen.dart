import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/categories_button_title_widget.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget_grid.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo_imp.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/sub_categories_cubit.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/sub_categories_states.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> categories = [];
  List<String> images = [
    'assets/svg_icons/noto_crown.svg',
    'assets/svg_icons/noto_crown.svg',
    'assets/svg_icons/noto_crown.svg',
    'assets/svg_icons/noto_crown.svg',
  ];
  String crownImage = 'assets/svg_icons/noto_crown.svg';

  final List<GlobalKey> sectionKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  List<int> itemsCount = [5, 5, 5, 5];
  late ScrollController scrollController;
  BuildContext? tabContext;
  late SubCategoriesCubit subCategoriesCubit;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_handleScroll);
    subCategoriesCubit =
        SubCategoriesCubit(SubCategoriesRepoImp(api: ApiService()));
    subCategoriesCubit.fetchSubCategories(2);
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

        if (position.dy <= box.size.height + screenHeight / 2 &&
            position.dy > screenHeight / 2) {
          if (position.dy <= screenHeight) {
            if (!isLoading && itemsCount[i] < 50) {
              isLoading = true;
              itemsCount[i] += 5;

              Future.delayed(const Duration(seconds: 2)).then((_) {
                isLoading = false;
              });

              setState(() {});
            }
          }
          DefaultTabController.of(tabContext!).animateTo(i);
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    scrollController.removeListener(_handleScroll);
    final context = sectionKeys[index].currentContext!;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
    ).then((value) {
      scrollController.addListener(_handleScroll);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubCategoriesCubit>.value(
      value: subCategoriesCubit,
      child: BlocBuilder<SubCategoriesCubit, FetchCategoriesState>(
        builder: (context, state) {
          if (state is SubCategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SubCategoriesFailure) {
            return Center(child: Text(state.message));
          } else if (state is SubCategoriesSuccess) {
            categories =
                state.subCategories.map((subCat) => subCat.name ?? "").toList();

            // Ensure categories are available
            if (categories.isEmpty) {
              return const Center(child: Text("No categories available"));
            }

            return DefaultTabController(
              length: categories.length,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(180.h),
                  child: Builder(
                    builder: (context) {
                      tabContext = context;
                      return SizedBox(
                        height: 170.h,
                        width: double.infinity,
                        child: AppBar(
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
                            title: 'Bakeries And Pastries',
                          ),
                          actions: const [
                            CartCounter(),
                          ],
                          bottom: ButtonsTabBar(
                            splashColor: MyColors.mainColor,
                            height: 75.h,
                            backgroundColor:
                                const Color.fromRGBO(204, 229, 233, 1),
                            unselectedBackgroundColor: Colors.white,
                            unselectedBorderColor:
                                const Color.fromRGBO(170, 170, 170, 1),
                            labelStyle: Styles.styles15w400NormalBlack.copyWith(
                                fontWeight: FontWeight.w600,
                                color: MyColors.mainColor),
                            borderColor: Colors.transparent,
                            borderWidth: 1.sp,
                            unselectedLabelStyle:
                                Styles.styles15w400NormalBlack.copyWith(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(150, 150, 150, 1),
                            ),
                            radius: 30.r,
                            buttonMargin: EdgeInsets.all(10.sp),
                            contentCenter: true,
                            labelSpacing: 10.sp,
                            contentPadding: EdgeInsets.all(12.sp),
                            onTap: (index) => _scrollToSection(index),
                            tabs: [
                              ...List.generate(
                                categories.length,
                                (index) => Tab(
                                  icon: Image.asset(
                                      "assets/Icons_logos/Donuts.png"),
                                  text: categories[index],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                              categories.length,
                              (index) {
                                return Column(
                                  key: sectionKeys[index],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      categories[index],
                                      style: Styles.styles21w700black,
                                    ),
                                    SizedBox(height: 16.h),
                                    itemWidgetGridView(
                                        itemCount: itemsCount.isNotEmpty &&
                                                itemsCount.length > index
                                            ? itemsCount[index]
                                            : 0),
                                    SizedBox(height: 60.h),
                                  ],
                                );
                              },
                            ),
                          ],
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
          return Container(); // Fallback empty container
        },
      ),
    );
  }
}
