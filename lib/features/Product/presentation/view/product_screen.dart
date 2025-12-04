import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/categories_bottom_sheet.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view/widgets/product_widget.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view_model/cubit/product_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductScreen extends StatefulWidget {
  final int productId;
  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String title = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductDetails(widget.productId),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is GetProductSuccess) {
            title = state.productModel.category!.name!;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: returnArrow(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: CategoriesBottomSheet(
                title: title,
              ),
              actions: const [
                CartCounter(),
              ],
            ),
            body: Column(
              children: [
                if (state is GetProductSuccess)
                  Expanded(
                    child: SingleChildScrollView(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              LocaleKeys.product_screen_related_products.tr(),
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
                    ),
                  ),
                if (state is GetProductLoading)
                  Skeletonizer(
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
                            height: 240,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                7,
                                (index) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 25,
                                    horizontal: 10,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  height: 240,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.heart_broken),
                                        ],
                                      ),
                                      Helper.loadNetworkImage(
                                        assetsErrorPath:
                                            'assets/screens_background/home-category.png',
                                      ),
                                      Text(LocaleKeys.product_screen_hello_there
                                          .tr()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                if (state is GetProductFailure)
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state
                            .error), // This is a variable, not a hardcoded string
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<ProductCubit>(context)
                                .getProductDetails(widget.productId);
                          },
                          child: Text(
                              LocaleKeys.product_screen_tap_to_try_again.tr()),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: const CartContainer(),
          );
        },
      ),
    );
  }
}
