import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/cart_item_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/floating_button_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/loading_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget initialWidget = const Text('Initial Widget');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartProducts(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartLoadingState) {
            initialWidget = Center(
              child: CircularProgressIndicator(color: MyColors.mainColor),
            );
          }

          if (state is CartFailedState) {
            initialWidget = Center(child: Text(state.error));
          }
        },
        builder: (context, state) {
          CartCubit cartCubit = BlocProvider.of<CartCubit>(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Cart'),
              backgroundColor: MyColors.mainScaffoldWhiteColor,
              elevation: 0,
              leading: returnArrow(
                context: context,
                onTap: () {
                  try {
                    BlocProvider.of<HomeLayoutCubit>(context)
                        .returnIndex(context);
                  } catch (e) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamed(context, homeLayout);
                    }
                  }
                },
              ),
            ),
            body: state is CartSuccessState || state is CartDeletingState
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          itemBuilder: (context, index) => CartItemWidget(
                            itemUiModel: ItemUiModel(
                              id: cartCubit.tableValues[index][cartItemId]
                                  as int,
                              name: cartCubit.tableValues[index][cartItemName]
                                  as String,
                              enName: cartCubit.tableValues[index]
                                  [cartItemEnName] as String,
                              enDesc: cartCubit.tableValues[index]
                                  [cartItemEnDesc] as String,
                              description: cartCubit.tableValues[index]
                                  [cartItemDesc] as String,
                              thumbnailImage: cartCubit.tableValues[index]
                                  [cartItemImageUrl] as String,
                              price: cartCubit.tableValues[index][cartItemPrice]
                                  as double,
                              quantity: cartCubit.tableValues[index]
                                  [cartItemQty] as int,
                              discount: cartCubit.tableValues[index]
                                  [cartItemDiscount] as double,
                            ),
                            onDelete: cartCubit.deleteItem,
                          ),
                          itemCount: cartCubit.tableValues.length,
                        ),
                        SizedBox(
                          height: 293.h,
                        ),
                      ],
                    ),
                  )
                : loadingWidget(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: const FloatingButtonWidget(),
          );
        },
      ),
    );
  }
}
