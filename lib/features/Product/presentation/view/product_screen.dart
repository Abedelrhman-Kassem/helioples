import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/categories_button_title_widget.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view/widgets/product_widget.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view_model/cubit/product_cubit.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductDetails(),
      child: Scaffold(
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
        body: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is GetProductFailure) {
              print(state.error);
            }

            if (state is GetProductSuccess) {
              print(state.product.name);
            }
          },
          builder: (context, state) {
            return state is GetProductSuccess
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ProductWidget(
                            product: state.product,
                          ),
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
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10.w),
                                itemCount: 10,
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),
                        SizedBox(height: 100.h),
                      ],
                    ),
                  )
                : Text('hello');
          },
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
