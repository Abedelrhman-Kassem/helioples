import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/cancel_order_bottom_sheet.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/shipping_details_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';

class CheckoutDetailsScreen extends StatelessWidget {
  const CheckoutDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: returnArrow(
          context: context,
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              homeLayout,
              (route) => false,
            );
          },
        ),
        title: const Text('Order Details'),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/screens_background/grocery_itemsback_ground.png',
            ),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              shippingDetailsContainer(),
              Container(
                padding: EdgeInsets.all(20.r),
                margin: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return itemWidget();
                  },
                  itemCount: 4,
                ),
              ),
              addressContainer(),
              paymentContainer(),
              scheduleContainer(),
              paymentDetails(context),
              SizedBox(height: 160.h),
            ],
          ),
        ),
      ),
      bottomSheet: bottomSheet(context),
    );
  }
}

Widget addressContainer() {
  return Container(
    padding: EdgeInsets.all(20.r),
    margin: EdgeInsets.symmetric(vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Address',
          style: Styles.styles17w700Black,
        ),
        SizedBox(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                svgIcon(
                  path: 'assets/svg_icons/location.svg',
                  width: 21.w,
                  height: 21.h,
                  color: const Color.fromRGBO(71, 71, 71, 1),
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  width: 240.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Home',
                        style: Styles.styles16w400NormalBlack,
                      ),
                      Text(
                        'Omar Ibn Al Khatab Street 436A',
                        style: Styles.styles12w400black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
            trailing: Container(
              width: 17.w,
              height: 17.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // To make it look like a radio button
                border: Border.all(
                  color: const Color.fromRGBO(248, 147, 31, 1),
                  width: 0.88.r,
                ),
              ),
              child: Align(
                child: Container(
                  width: 6.38.w,
                  height: 6.38.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(248, 147, 31, 1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget paymentContainer() {
  return Container(
    padding: EdgeInsets.all(20.r),
    margin: EdgeInsets.symmetric(vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment',
          style: Styles.styles17w700Black,
        ),
        SizedBox(height: 20.h),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(248, 147, 31, 0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              width: 0.5,
              color: const Color.fromRGBO(248, 147, 31, 1),
            ),
          ),
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                svgIcon(
                  path: 'assets/svg_icons/cash-on-delivery.svg',
                  width: 32.12.w,
                  height: 32.12.h,
                  color: const Color.fromRGBO(41, 41, 41, 1),
                ),
                SizedBox(width: 20.w),
                Text(
                  'Cash on delivery',
                  style: Styles.styles15w400Black,
                )
              ],
            ),
            trailing: Container(
              width: 17.w,
              height: 17.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // To make it look like a radio button
                border: Border.all(
                  color: const Color.fromRGBO(248, 147, 31, 1),
                  width: 0.88.r,
                ),
              ),
              child: Align(
                child: Container(
                  width: 6.38.w,
                  height: 6.38.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(248, 147, 31, 1)),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget scheduleContainer() {
  return Container(
    padding: EdgeInsets.all(20.r),
    margin: EdgeInsets.symmetric(vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Time',
          style: Styles.styles17w700Black,
        ),
        SizedBox(height: 20.h),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(248, 147, 31, 0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              width: 0.5,
              color: const Color.fromRGBO(248, 147, 31, 1),
            ),
          ),
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                svgIcon(
                  path: 'assets/svg_icons/hand-clock.svg',
                  width: 18.w,
                  height: 18.h,
                  color: const Color.fromRGBO(41, 41, 41, 1),
                ),
                SizedBox(width: 5.w),
                RichText(
                  text: TextSpan(
                    text: 'Instant, ',
                    style: Styles.styles12w400black.copyWith(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Arrive at 7:30 PM',
                        style: Styles.styles12w400Gold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 17.w,
              height: 17.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // To make it look like a radio button
                border: Border.all(
                  color: const Color.fromRGBO(248, 147, 31, 1),
                  width: 0.88.r,
                ),
              ),
              child: Align(
                child: Container(
                  width: 6.38.w,
                  height: 6.38.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(248, 147, 31, 1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget paymentDetails(BuildContext context) {
  String textToCopy = '#16515305';

  void copyToClipboard(BuildContext context) {
    Clipboard.setData(
      ClipboardData(text: textToCopy),
    ).then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Copied to clipboard!'),
          ),
        );
      },
    );
  }

  return Container(
    padding: EdgeInsets.all(20.r),
    margin: EdgeInsets.only(top: 10.h),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              'Order Number',
              style: Styles.styles14w400Black,
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                copyToClipboard(context);
              },
              child: svgIcon(
                path: 'assets/svg_icons/copy-success.svg',
                width: 18.w,
                height: 18.h,
                color: MyColors.mainColor,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              textToCopy,
              style: Styles.styles15w600NormalBlack,
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sub Total (4 Items)',
              style: Styles.styles14w400Black,
            ),
            Text(
              '300.00 EGP',
              style: Styles.styles15w600NormalBlack,
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Promocode Discount',
              style: Styles.styles14w400Black,
            ),
            Text(
              '120.00 EGP',
              style: Styles.styles15w600NormalBlack,
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery fees',
              style: Styles.styles14w400Black,
            ),
            Text(
              '120 EGP',
              style: Styles.styles15w600NormalBlack,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget bottomSheet(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20.r),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20.h),
          padding: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
            bottom: 5.w,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(210, 210, 210, 1),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: Styles.styles18w500BlackWhite,
              ),
              Text(
                '214 EGP',
                style: Styles.styles18w800Black,
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(36.77.r),
            splashColor: MyColors.mainColor,
            onTap: () async {
              return showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return cancelOrderBottomSheet(context);
                  });
            },
            child: Container(
              width: 284.w,
              height: 58.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36.77.r),
                color: MyColors.mainColor.withOpacity(.9),
              ),
              child: Text(
                'Cancel Order',
                style: Styles.styles17w500NormalWhite,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
