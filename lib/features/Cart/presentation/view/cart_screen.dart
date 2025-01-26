import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/cart_item_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/floating_button_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/loading_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

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
          List<Map<String, Object?>> tableValues = cartCubit.tableValues;

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
                              id: tableValues[index][cartItemId] as int,
                              name: tableValues[index][cartItemName] as String,
                              enName:
                                  tableValues[index][cartItemEnName] as String,
                              enDesc:
                                  tableValues[index][cartItemEnDesc] as String,
                              description:
                                  tableValues[index][cartItemDesc] as String,
                              thumbnailImage: tableValues[index]
                                  [cartItemImageUrl] as String,
                              price:
                                  tableValues[index][cartItemPrice] as double,
                              discount: tableValues[index][cartItemDiscount]
                                  as double,
                              quantity: tableValues[index][cartItemQty] as int,
                              availablePieces: cartCubit.getAvailablePieces(
                                tableValues[index][cartItemId] as int,
                              ),
                            ),
                            onDelete: cartCubit.deleteItem,
                          ),
                          itemCount: tableValues.length,
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
