import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/cart_item_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/floating_button_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/loading_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget initialWidget = Text(LocaleKeys.cart_screen_initial_widget.tr());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartProducts(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartSuccessState) {
            String message = state.updateCartModel.message ?? "";
            log(message);
            if (message.isNotEmpty) {
              String formattedMessage = message.replaceAllMapped(
                RegExp(r'\)(?=\s*Product)'),
                (match) => ').',
              );

              List<String> st = formattedMessage.split(".");
              List<String> validMessages = st
                  .where((element) => element.trim().isNotEmpty)
                  .toList();
              log(validMessages.toString());

              if (validMessages.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    title: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: MyColors.mainColor,
                          size: 28.sp,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          LocaleKeys.cart_screen_update
                              .tr(), // You might want to localize this
                          style: Styles.styles16w700interFamily.copyWith(
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: validMessages
                          .map(
                            (e) => Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8.sp,
                                    color: MyColors.mainColor,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      e,
                                      style: Styles.styles14w400Black.copyWith(
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: MyColors.mainColor,
                          textStyle: Styles.styles16w700interFamily,
                        ),
                        child: Text(LocaleKeys.cart_screen_ok.tr()),
                      ),
                    ],
                  ),
                );
              }
            }
          }
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
              title: Text(LocaleKeys.cart_screen_cart.tr()),
              backgroundColor: MyColors.mainScaffoldWhiteColor,
              elevation: 0,
              leading: returnArrow(
                context: context,
                onTap: () {
                  try {
                    BlocProvider.of<HomeLayoutCubit>(
                      context,
                    ).returnIndex(context);
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
                          itemBuilder: (context, index) {
                            return CartItemWidget(
                              itemUiModel: Products(
                                isLiked: cartCubit.getIsLiked(
                                  tableValues[index][cartItemId] as String,
                                ),
                                state: cartCubit.getProductState(
                                  tableValues[index][cartItemId] as String,
                                ),
                                id: tableValues[index][cartItemId] as String,
                                name:
                                    tableValues[index][cartItemName] as String,
                                enName:
                                    tableValues[index][cartItemEnName]
                                        as String,
                                description:
                                    tableValues[index][cartItemEnDesc]
                                        as String,
                                thumbnailImage:
                                    tableValues[index][cartItemImageUrl]
                                        as String,
                                price:
                                    (tableValues[index][cartItemPrice] as num)
                                        .toDouble(),
                                discount:
                                    (tableValues[index][cartItemDiscount]
                                            as num)
                                        .toDouble(),
                                quantity:
                                    (tableValues[index][cartItemQty] as num)
                                        .toDouble(),
                                availableQuantity: cartCubit.getAvailablePieces(
                                  tableValues[index][cartItemId] as String,
                                ),
                              ),
                              onDelete: cartCubit.deleteItem,
                            );
                          },
                          itemCount: tableValues.length,
                        ),
                        SizedBox(height: 293.h),
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
