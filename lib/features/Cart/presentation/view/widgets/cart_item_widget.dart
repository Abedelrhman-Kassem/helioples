import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/cart_item_icon_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class CartItemWidget extends StatefulWidget {
  final ItemUiModel itemUiModel;
  final Future<void> Function(int) onDelete;
  const CartItemWidget({
    super.key,
    required this.itemUiModel,
    required this.onDelete,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    var product = widget.itemUiModel;

    Future<void> updateQty() async {
      await DBHelper.updateData(
        table: cartItemTable,
        values: {
          cartItemQty: product.quantity,
        },
        where: 'id = ?',
        whereArgs: [product.id],
      );
    }

    return Container(
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
              boxShadow: [
                MyBoxShadows.cartCardBoxShadow,
              ],
            ),
            child: Center(
              child: Helper.loadNetworkImage(
                url: product.thumbnailImage,
                assetsErrorPath: 'assets/test_images/water-bottle.png',
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
                  product.name,
                  style: Styles.styles15w500Black,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${product.quantity} Pcs (${product.price} EGP)',
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
                          await widget.onDelete(product.id);
                        }
                      },
                      isBiggerThanOne: product.quantity > 1,
                      minusSvgPath: 'assets/svg_icons/empty-minus.svg',
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      '${product.quantity}',
                      style: Styles.styles15w400NormalBlack,
                    ),
                    SizedBox(width: 10.w),
                    cartItemIconWidget(
                      svgPath: 'assets/svg_icons/empty-plus.svg',
                      onTap: () {
                        product.quantity++;
                        updateQty();
                        setState(() {});
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
                    await widget.onDelete(product.id);
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
                    text: '${(product.price * product.quantity).toInt()}.',
                    style: Styles.styles26w600NormalBlack,
                    children: [
                      TextSpan(
                        text:
                            '${(((product.price * product.quantity) - (product.price * product.quantity).toInt()) * 100).round()}',
                        style: Styles.styles14w300NormalBlack,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
