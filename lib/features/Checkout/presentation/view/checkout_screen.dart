import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/Helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/radio_item.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/core/widgets/delivery_address_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/tips_widget.dart';

class Tips {
  String textValue;
  int value;

  Tips(this.textValue, this.value);
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String addressRadioValue = 'Home';
  int radioValue = 0;
  int tipsValue = 0;
  // int customTip = 0;

  TextEditingController promoCodeController = TextEditingController();

  List<Tips> tipsList = [
    Tips('10 EGP', 10),
    Tips('20 EGP', 20),
    Tips('30 EGP', 30),
    Tips('40 EGP', 40),
  ];

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: returnArrow(
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Checkout'),
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
                    return Row(
                      children: [
                        Text(
                          'x2',
                          style: Styles.styles12w300NormalBlack,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          width: 70.w,
                          height: 70.h,
                          child: Helper.loadNetworkImage(
                            assetsErrorPath:
                                'assets/test_images/mango-category.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 170.w,
                          child: Text(
                            'Butter Croissant',
                            style: Styles.styles14w400Black.copyWith(
                              color: const Color.fromRGBO(50, 50, 50, 1),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '120.00',
                          style: Styles.styles21w400NormalBlack,
                        ),
                      ],
                    );
                  },
                  itemCount: 4,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.r),
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Time',
                          style: Styles.styles17w700Black,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            svgIcon(
                              path: 'assets/svg_icons/hand-clock.svg',
                              width: 18.w,
                              height: 18.h,
                              color: const Color.fromRGBO(41, 41, 41, 1),
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'Instant, ',
                                style: Styles.styles12w400black,
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
                      ],
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            svgIcon(
                              path: 'assets/svg_icons/calendar.svg',
                              width: 18.w,
                              height: 18.h,
                              color: MyColors.mainColor,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'Schedule',
                              style: Styles.styles12w400MainColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.r),
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Address',
                          style: Styles.styles17w700Black,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                svgIcon(
                                  path: 'assets/svg_icons/empty-plus.svg',
                                  width: 18.w,
                                  height: 18.h,
                                  color: MyColors.mainColor,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'Add Address',
                                  style: Styles.styles12w400MainColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    deliveryAddressWidget(
                      addressTitleRadioValue: addressRadioValue,
                      location: 'Salah Salem Street 44C, Maadi, Cairo',
                      title: 'Home',
                      onTap: () {
                        setState(() {
                          addressRadioValue = 'Home';
                        });
                      },
                    ),
                    deliveryAddressWidget(
                        addressTitleRadioValue: addressRadioValue,
                        location: 'Omar Ibn Al Khatab Street 436A',
                        title: 'Work',
                        onTap: () {
                          setState(() {
                            addressRadioValue = 'Work';
                          });
                        }),
                  ],
                ),
              ),
              Container(
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
                    radioItem(
                      title: 'Cash on delivery',
                      iconPath: 'cash-on-delivery',
                      index: 0,
                      radioValue: radioValue,
                      onTap: () {
                        setState(() {
                          radioValue = 0;
                        });
                      },
                    ),
                    radioItem(
                      title: 'Card on delivery',
                      iconPath: 'card-on-delivery',
                      index: 1,
                      radioValue: radioValue,
                      onTap: () {
                        setState(() {
                          radioValue = 1;
                        });
                      },
                    ),
                    radioItem(
                      title: 'Credit/Debit card',
                      iconPath: 'credit-or-debit-card',
                      index: 2,
                      radioValue: radioValue,
                      onTap: () {
                        setState(() {
                          radioValue = 2;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.r),
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Appreciate delivery with tips',
                              style: Styles.styles17w700Black,
                            ),
                            Text(
                              'Tips amount will go directly to the delivery labor',
                              style: Styles.styles12w300NormalBlack.copyWith(
                                color: const Color.fromRGBO(120, 120, 120, 1),
                              ),
                            ),
                          ],
                        ),
                        svgIcon(
                          path:
                              'assets/svg_icons/appreciate-delivery-with-tips.svg',
                          width: 29.w,
                          height: 29.h,
                          color: const Color.fromRGBO(255, 202, 40, 1),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        spacing: 10.w,
                        children: [
                          ...List.generate(
                            tipsList.length,
                            (index) {
                              return tipsWidget(
                                text: tipsList[index].textValue,
                                value: tipsList[index].value,
                                tipsValue: tipsValue,
                                onTap: () {
                                  setState(() {
                                    tipsValue = tipsList[index].value;
                                  });
                                },
                              );
                            },
                          ),
                          tipsWidget(
                            text: 'Custom',
                            onTap: () {
                              setState(() {
                                tipsValue = 500;
                              });
                            },
                            value: 500,
                            tipsValue: tipsValue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                      'Promo code',
                      style: Styles.styles17w700Black,
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33.06.r),
                        border: Border.all(
                          color: const Color.fromRGBO(246, 246, 246, 1),
                        ),
                      ),
                      child: TextField(
                        controller: promoCodeController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 15.h,
                          ),
                          hintText: 'Enter Promo code',
                          border: InputBorder.none,
                          hintStyle: Styles.styles17w400interFamily.copyWith(
                            color: const Color.fromRGBO(181, 185, 190, 1),
                          ),
                          suffixIcon: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Apply',
                              style: Styles.styles17w500MainColor,
                            ),
                          ),
                        ),
                        cursorColor: MyColors.mainColor,
                        style: Styles.styles17w700MainColor,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            // exploreCubit.changeSearchExplore(value.trim());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.r),
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  children: [
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
              ),
              SizedBox(height: 150.h),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
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
                onTap: () {
                  // Navigator.pushNamed(context, checkoutScreen);
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
                    'Place Order',
                    style: Styles.styles17w500NormalWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
