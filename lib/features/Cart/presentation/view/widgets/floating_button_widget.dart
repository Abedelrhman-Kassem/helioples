import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
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
                    'Sub Total (${_dbChangeNotifier.dbData.count} Items)',
                    style: Styles.styles14w400NormalWhite,
                  ),
                  Text(
                    '${_dbChangeNotifier.dbData.totalPrice} EGP',
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
                    '${_dbChangeNotifier.dbData.totalPrice} EGP',
                    style: Styles.styles18w800NormalWhite,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const ModalBottomSheet();
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
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
                              text:
                                  '${_dbChangeNotifier.dbData.totalPrice} EGP',
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
