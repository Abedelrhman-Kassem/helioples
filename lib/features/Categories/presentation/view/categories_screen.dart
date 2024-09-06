import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/categories_button_title_widget.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget_grid.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isFeatured = true;
  List<String> categories = [
    "Croissant",
    "Toast",
    "Muffins",
    "Donuts",
  ];
  List<String> images = [
    "assets/Icons_logos/Croissant.png",
    "assets/Icons_logos/Toast.png",
    "assets/Icons_logos/Muffins.png",
    "assets/Icons_logos/Donuts.png",
  ];
  String crownImage = 'assets/svg_icons/noto_crown.svg';

  // Keys for each section
  final List<GlobalKey> sectionKeys = [
    GlobalKey(), // For "Featured" tab
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  // ScrollController to listen to scrolling events
  late ScrollController scrollController;
  BuildContext? tabContext;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    for (int i = 0; i < sectionKeys.length; i++) {
      final RenderBox? box =
          sectionKeys[i].currentContext!.findRenderObject() as RenderBox?;
      if (box != null) {
        final position = box.localToGlobal(Offset.zero);
        if (position.dy <= 300 && position.dy + box.size.height > 300) {
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
    return DefaultTabController(
      length: isFeatured ? categories.length + 1 : categories.length,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(180.h),
            child: Builder(
              builder: (context) {
                tabContext = context;
                return SizedBox(
                  height: 150.h,
                  width: double.infinity,
                  child: AppBar(
                    toolbarHeight: 200.h,
                    elevation: 20,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    title: categoriesButtonTitleWidet(
                      context: context,
                      title: 'Bakeries And Pastries',
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SizedBox(
                          width: 40.w,
                          height: 50.h,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 10.h,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    "assets/svg_icons/favorite-Cart.svg",
                                    height: 35.h,
                                    width: 35.w,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5.w,
                                top: 5.h,
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(228, 144, 42, 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "3",
                                      style: Styles.styles11w600White.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    bottom: ButtonsTabBar(
                      splashColor: MyColors.mainColor,
                      height: 75.h,
                      backgroundColor: const Color.fromRGBO(204, 229, 233, 1),
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
                        if (isFeatured)
                          Tab(
                            icon: SvgPicture.asset(crownImage),
                            text: "Featured",
                          ),
                        ...List.generate(
                          categories.length,
                          (index) => Tab(
                            icon: Image.asset(images[index]),
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
                controller: scrollController,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isFeatured)
                        Column(
                          key: sectionKeys[0],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Featured",
                              style: Styles.styles21w700black,
                            ),
                            SizedBox(height: 16.h),
                            const FeatureWidget(), // Add your FeatureWidget here
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ...List.generate(categories.length, (index) {
                        return Column(
                          key: sectionKeys[isFeatured ? index + 1 : index],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categories[index],
                              style: Styles.styles21w700black,
                            ),
                            SizedBox(height: 16.h),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                crossAxisSpacing: 7,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.25 / 2.25,
                              ),
                              itemCount: categories.length,
                              itemBuilder: (context, i) {
                                return ItemWidget(
                                  counter: 0,
                                  isFavorite: false,
                                );
                              },
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: CartContainer(
                  svgIconPath: "assets/svg_icons/favorite-Cart.svg",
                  buttonText: "Go To Cart",
                  productsCount: "3",
                  totalAmount: "310",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
