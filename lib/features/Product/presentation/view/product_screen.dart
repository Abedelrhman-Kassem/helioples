import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/categories_bottom_sheet.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view/widgets/product_widget.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view/widgets/related_prod_loading.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view_model/cubit/product_cubit.dart';
import 'package:negmt_heliopolis/core/widgets/pagination_listener.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductScreen extends StatefulWidget {
  final String productId;
  final Products? product;
  final bool isFromNoti;
  const ProductScreen({
    super.key,
    required this.productId,
    this.product,
    this.isFromNoti = false,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String title = '';
  Products? currentProduct;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentProduct = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductDetails(widget.productId),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          final cubit = BlocProvider.of<ProductCubit>(context);

          if (state is GetProductSuccess && cubit.isFirstFetch) {
            log("دخل هنا");
            currentProduct = state.productModel.data;
            setState(() {
              isLoading = false;
            });
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<ProductCubit>(context);
          return Scaffold(
            appBar: AppBar(
              leading: returnArrow(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: CategoriesBottomSheet(title: title),
              actions: const [CartCounter()],
            ),
            body: Column(
              children: [
                if (currentProduct != null)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ProductWidget(
                              product: currentProduct!,
                              isload: isLoading,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Text(
                              LocaleKeys.product_screen_related_products.tr(),
                              style: Styles.styles16w600NormalBlack,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          if (cubit.products.isNotEmpty)
                            SizedBox(
                              height: 210,
                              child: PaginationListener(
                                scrollDirection: Axis.horizontal,
                                isLoading: cubit.isLoading,
                                onLoadMore: () {
                                  cubit.getProductDetails(widget.productId);
                                },
                                child: CustomScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  slivers: [
                                    const SliverToBoxAdapter(
                                      child: SizedBox(width: 20),
                                    ),
                                    SliverList.separated(
                                      itemBuilder: (context, index) =>
                                          ItemWidget(
                                            relatedProductsModel:
                                                cubit.products[index],
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 10.w),
                                      itemCount: cubit.products.length,
                                    ),
                                    if (state is GetProductLoading)
                                      const SliverToBoxAdapter(
                                        child: SizedBox(
                                          width: 1000,
                                          child: RelatedProdLoading(),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            )
                          else if (state is GetProductLoading)
                            const RelatedProdLoading(),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  )
                else if (state is GetProductLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (state is GetProductFailure)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.error,
                            style: Styles.styles16w600NormalBlack,
                            textAlign: TextAlign.center,
                          ), // This is a variable, not a hardcoded string
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<ProductCubit>(
                                context,
                              ).getProductDetails(widget.productId);
                            },
                            child: Text(
                              LocaleKeys.product_screen_tap_to_try_again.tr(),
                            ),
                          ),
                        ],
                      ),
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
