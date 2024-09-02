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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProductWidget(),
              SizedBox(height: 30.h),
              Text(
                'Related Products',
                style: Styles.styles16w600NormalBlack,
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ItemWidget(
                    counter: 0,
                    isFavorite: false,
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 15.w),
                  itemCount: 10,
                ),
              )
              //             maxCrossAxisExtent: 150,
              // crossAxisSpacing: 7,
              // mainAxisSpacing: 10,
              // childAspectRatio: 1.2 / 2.25,
            ],
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
    );
  }
}
