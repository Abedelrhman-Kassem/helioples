import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/categories_button_title_widget.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view/widgets/product_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          cartCounter(context: context),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: ProductWidget(),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Related Products',
                style: Styles.styles16w600NormalBlack,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 210,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 20),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ItemWidget(
                      counter: 0,
                      isFavorite: false,
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10.w),
                    itemCount: 10,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CartContainer(
        svgIconPath: "assets/svg_icons/favorite-Cart.svg",
        buttonText: "Go To Cart",
        productsCount: "3",
        totalAmount: "310",
      ),
    );
  }
}
