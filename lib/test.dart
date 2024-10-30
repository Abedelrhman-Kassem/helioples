import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/categories_button_title_widget.dart';
import 'package:negmt_heliopolis/core/widgets/feature_widget.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget_grid.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isFeatured = false;
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

  List<int> itemsCount = [5, 5, 5, 5];

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

  bool isLoading = false;

  void _handleScroll() {
    final screenHeight = MediaQuery.of(context).size.height;

    for (int i = 0; i < sectionKeys.length; i++) {
      final RenderBox? box =
          sectionKeys[i].currentContext!.findRenderObject() as RenderBox?;

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
    return DefaultTabController(
      length: isFeatured ? categories.length + 1 : categories.length,
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
                      }),
                  title: categoriesButtonTitleWidet(
                    context: context,
                    title: 'Bakeries And Pastries',
                  ),
                  actions: [
                    cartCounter(
                      context: context,
                    )
                  ],
                  bottom: ButtonsTabBar(
                    splashColor: MyColors.mainColor,
                    height: 79.h,
                    backgroundColor: const Color.fromRGBO(204, 229, 233, 1),
                    unselectedBackgroundColor: Colors.white,
                    unselectedBorderColor:
                        const Color.fromRGBO(170, 170, 170, 1),
                    labelStyle: Styles.styles15w400NormalBlack.copyWith(
                        fontWeight: FontWeight.w600, color: MyColors.mainColor),
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
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
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
                    ...List.generate(
                      categories.length,
                      (index) {
                        return Column(
                          key: sectionKeys[isFeatured ? index + 1 : index],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categories[index],
                              style: Styles.styles21w700black,
                            ),
                            SizedBox(height: 16.h),
                            itemWidgetGridView(itemCount: itemsCount[index]),
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
    );
  }
}
