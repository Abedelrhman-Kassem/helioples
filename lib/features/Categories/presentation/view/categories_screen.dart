import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  // Keys for each section
  final List<GlobalKey> sectionKeys = [
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
    // bool tabChanged = false ;
    for (int i = 0; i < sectionKeys.length; i++) {
      final RenderBox? box =
          sectionKeys[i].currentContext!.findRenderObject() as RenderBox?;
      if (box != null) {
        final position = box.localToGlobal(Offset.zero);
        if (position.dy <= 300 && position.dy + box.size.height > 300) {
          DefaultTabController.of(tabContext!).animateTo(i);
          // tabChanged = true;
          break;
        }
      }
    }

    // if(!tabChanged)
    // {
    //   final scrollableBottom  = scrollController.position.maxScrollExtent ;
    //   if(scrollController.position.pixels >= scrollableBottom)
    //   {
    //      DefaultTabController.of(tabContext!)?.animateTo(sectionKeys.length - 1);
    //   }

    // }
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
      length: categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(180.h),
          child: Builder(
            builder: (context) {
              tabContext = context;
              return SizedBox(
                height: 180.h,
                width: double.infinity,
                child: AppBar(
                  // toolbarHeight: 150.h,
                  elevation: 20,
                  backgroundColor: Colors.white,
                  leading: returnArrow(
                    context: context,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: categoriesButtonTitleWidet(
                    context: context,
                    title: 'Bakeries And Pastries',
                  ),
                  actions: [
                    cartCounter(
                      context: context,
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
                    tabs: List.generate(
                      categories.length,
                      (index) => Tab(
                        icon: Image.asset(images[index]),
                        text: categories[index],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(categories.length, (index) {
                return Column(
                  key: sectionKeys[index],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categories[index],
                      style: Styles.styles21w700black,
                    ),
                    SizedBox(height: 16.h),
                    itemWidgetGridView(),
                    SizedBox(height: 80.h),
                  ],
                );
              }),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const CartContainer(
          svgIconPath: "assets/svg_icons/favorite-Cart.svg",
          buttonText: "Go To Cart",
          productsCount: "3",
          totalAmount: "310",
        ),
      ),
    );
  }
}
