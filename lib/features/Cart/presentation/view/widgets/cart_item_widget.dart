import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/cart_item_icon_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({super.key});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
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
                  'Nestle Pure Life 1.5 Litres',
                  style: Styles.styles15w500interFamily,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '3 Pcs (25 EGP)',
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
                      onTap: () {},
                      isBiggerThanOne: false,
                      minusSvgPath: 'assets/svg_icons/empty-minus.svg',
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      '1',
                      style: Styles.styles15w400NormalBlack,
                    ),
                    SizedBox(width: 10.w),
                    cartItemIconWidget(
                      svgPath: 'assets/svg_icons/empty-plus.svg',
                      onTap: () {},
                      isBiggerThanOne: true,
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
                  onTap: () {},
                  child: svgIcon(
                    path: 'assets/svg_icons/trash.svg',
                    width: 21.71.w,
                    height: 21.71.h,
                    color: const Color.fromRGBO(204, 42, 40, 1),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '75.',
                    style: Styles.styles26w600NormalBlack,
                    children: [
                      TextSpan(
                        text: '00',
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
