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
  final Products product;
  const ProductScreen(
      {super.key, required this.productId, required this.product});

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
          // if (state is GetProductSuccess) {
          //   title = state.productModel.category!.name!;
          // }
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
              title: CategoriesBottomSheet(
                title: title,
              ),
              actions: const [
                CartCounter(),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ProductWidget(
                            product: widget.product,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                    // const SliverToBoxAdapter(
                                    //   child: SizedBox(width: 20),
                                    // ),
                                    if (state is GetProductLoading)
                                      const SliverToBoxAdapter(
                                          child: SizedBox(
                                              width: 1000,
                                              child: RelatedProdLoading())),
                                  ],
                                )),
                          )
                        else if (state is GetProductLoading)
                          const RelatedProdLoading(),
                        SizedBox(height: 100.h),
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
