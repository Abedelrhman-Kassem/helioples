import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/cart_item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: MyColors.mainScaffoldWhiteColor,
        elevation: 0,
        leading: returnArrow(
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              itemBuilder: (context, index) => const CartItemWidget(),
              itemCount: 6,
            ),
            SizedBox(
              height: 259.h,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        width: double.infinity,
        height: 259.h,
        decoration: BoxDecoration(
          color: MyColors.mainColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub Total (4 Items)',
                  style: Styles.styles14w400NormalWhite,
                ),
                Text(
                  '300.00 EGP',
                  style: Styles.styles15w600NormalWhite,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Promocode Discount',
                  style: Styles.styles14w400NormalWhite,
                ),
                Text(
                  '120.00 EGP',
                  style: Styles.styles15w600NormalWhite,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Container(
              height: 1.h,
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price',
                  style: Styles.styles14w400NormalWhite,
                ),
                Text(
                  '420.00 EGP',
                  style: Styles.styles18w800NormalWhite,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 84.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(36.77.r),
                  boxShadow: [
                    MyBoxShadows.checkOutBoxShadow,
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    svgIcon(
                      path: 'assets/svg_icons/wallet-check.svg',
                      width: 26.84.w,
                      height: 26.84.h,
                      color: MyColors.mainColor,
                    ),
                    SizedBox(width: 10.w),
                    RichText(
                      text: TextSpan(
                        text: 'Checkout ',
                        style: Styles.styles17w700MainColor,
                        children: [
                          TextSpan(
                            text: '420 EGP',
                            style: Styles.styles17w700MainColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
