import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/cart_item_icon_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class CartItemWidget extends StatefulWidget {
  final Products itemUiModel;
  final Future<void> Function(String) onDelete;

  const CartItemWidget({
    super.key,
    required this.itemUiModel,
    required this.onDelete,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late CartCubit cartCubit;

  @override
  void initState() {
    cartCubit = BlocProvider.of<CartCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Products product = widget.itemUiModel;

    Future<void> updateQty() async {
      await DBHelper.updateData(
        table: cartTable,
        values: {cartItemQty: product.quantity},
        where: 'id = ?',
        whereArgs: [product.id],
      );
    }

    return InkWell(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          productScreen,
          arguments: {'productId': product.id, 'product': product},
        );

        cartCubit.getCartProducts();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.h),
        height: 135.h,
        child: Row(
          children: [
            Container(
              width: 95.w,
              margin: EdgeInsets.symmetric(horizontal: 5.r),
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [MyBoxShadows.cartCardBoxShadow],
              ),
              child: Center(
                child: Helper.loadNetworkImage(
                  url: product.thumbnailImage!,
                  // assetsErrorPath: 'assets/test_images/water-bottle.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              width: 160.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: Styles.styles15w500Black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${product.availableQuantity} ${LocaleKeys.cart_screen_cart_item_pcs.tr()} (${product.price} ${LocaleKeys.cart_screen_cart_item_egp.tr()})',
                    style: Styles.styles10w400interFamily,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      cartItemIconWidget(
                        svgPath: 'assets/svg_icons/trash.svg',
                        onTap: () async {
                          if (product.quantity > 1) {
                            product.quantity--;
                            await updateQty();
                            setState(() {});
                          } else {
                            await widget.onDelete(product.id!);
                          }
                        },
                        isBiggerThanOne: product.quantity > 1,
                        minusSvgPath: 'assets/svg_icons/empty-minus.svg',
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        product.quantity.toStringAsFixed(0),
                        style: Styles.styles15w400NormalBlack,
                      ),
                      SizedBox(width: 10.w),
                      cartItemIconWidget(
                        svgPath: 'assets/svg_icons/empty-plus.svg',
                        onTap: () {
                          if (product.quantity < product.availableQuantity!) {
                            product.quantity++;
                            updateQty();
                            setState(() {});
                          } else {
                            CustomSnackBar.show(
                              context: context,
                              text: LocaleKeys
                                  .cart_screen_cart_item_cant_add_more
                                  .tr(
                                    namedArgs: {
                                      'pieces': product.availableQuantity
                                          .toString(),
                                    },
                                  ),
                              duration: const Duration(seconds: 10),
                              isGreen: false,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 120.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      await widget.onDelete(product.id!);
                    },
                    child: svgIcon(
                      path: 'assets/svg_icons/trash.svg',
                      width: 21.71.w,
                      height: 21.71.h,
                      color: const Color.fromRGBO(204, 42, 40, 1),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${(product.price! * product.quantity).toInt()}.',
                      style: Styles.styles26w600NormalBlack,
                      children: [
                        TextSpan(
                          text:
                              '${(((product.price! * product.quantity) - (product.price! * product.quantity).toInt()) * 100).round()}',
                          style: Styles.styles14w300NormalBlack,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
