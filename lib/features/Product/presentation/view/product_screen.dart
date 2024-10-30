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
import 'package:skeletonizer/skeletonizer.dart';

class ProductScreen extends StatefulWidget {
  final int productId;
  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductDetails(widget.productId),
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
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetProductSuccess) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ProductWidget(
                        product: state.productModel.product!,
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
                              relatedProductsModel:
                                  state.productModel.related![index],
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10.w),
                            itemCount: state.productModel.related!.length,
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              );
            }
            if (state is GetProductLoading) {
              return Skeletonizer(
                child: Padding(
                  padding: EdgeInsets.all(20.0.r),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400.h,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 50.h),
                      SizedBox(
                        height: 200.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            7,
                            (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.r),
                              height: 200.h,
                              width: 100.h,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            if (state is GetProductFailure) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.error),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<ProductCubit>(context)
                            .getProductDetails(widget.productId);
                      },
                      child: const Text('Tap to try again'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
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
