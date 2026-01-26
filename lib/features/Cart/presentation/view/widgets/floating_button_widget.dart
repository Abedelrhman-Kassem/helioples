import 'package:easy_localization/easy_localization.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/modal_bottom_sheet.dart';

class FloatingButtonWidget extends StatefulWidget {
  const FloatingButtonWidget({super.key});

  @override
  State<FloatingButtonWidget> createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  final DbChangeNotifier _dbChangeNotifier = DbChangeNotifier();

  @override
  void initState() {
    _dbChangeNotifier.fetchItemCount();
    _dbChangeNotifier.addListener(refreshState);
    super.initState();
  }

  void refreshState() {
    setState(() {});
  }

  @override
  void dispose() {
    _dbChangeNotifier.removeListener(refreshState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          width: double.infinity,
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
                    '${LocaleKeys.cart_modal_sub_total.tr()} (${_dbChangeNotifier.dbData.count} ${LocaleKeys.cart_modal_items.tr()})',
                    style: Styles.styles14w400NormalWhite,
                  ),
                  RichText(
                    text: Helper.priceSpan(
                      _dbChangeNotifier.dbData.totalPrice,
                      Styles.styles15w600NormalWhite,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.cart_modal_discount.tr(),
                    style: Styles.styles14w400NormalWhite,
                  ),
                  RichText(
                    text: Helper.priceSpan(
                      _dbChangeNotifier.dbData.totalDiscount,
                      Styles.styles15w600NormalWhite,
                    ),
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
                    LocaleKeys.cart_modal_total_price.tr(),
                    style: Styles.styles14w400NormalWhite,
                  ),
                  RichText(
                    text: Helper.priceSpan(
                      _dbChangeNotifier.dbData.totalPrice -
                          _dbChangeNotifier.dbData.totalDiscount,
                      Styles.styles18w800NormalWhite,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () async {
                  int items = _dbChangeNotifier.dbData.count;

                  items > 0
                      ? showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ModalBottomSheet(items: items);
                          },
                        )
                      : null;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(36.77.r),
                    boxShadow: [MyBoxShadows.checkOutBoxShadow],
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
                          text: '${LocaleKeys.cart_modal_checkout.tr()} ',
                          style: Styles.styles17w700MainColor,
                          children: [
                            TextSpan(
                              text: Helper.formatPrice(
                                _dbChangeNotifier.dbData.totalPrice -
                                    _dbChangeNotifier.dbData.totalDiscount,
                              ),
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
      ],
    );
  }
}
