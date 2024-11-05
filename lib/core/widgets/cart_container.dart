import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class CartContainer extends StatefulWidget {
  const CartContainer({super.key});

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, cartScreen);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 42.w),
        child: Container(
          height: 64.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: MyColors.mainColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3.sp,
                blurRadius: 5.sp,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                svgIcon(
                  path: "assets/svg_icons/favorite-Cart.svg",
                  width: 35.w,
                  height: 35.h,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Go to Cart',
                  style: Styles.styles12w500Black.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '${_dbChangeNotifier.dbData.count} ',
                        style: Styles.styles12w500Black.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextSpan(
                        text: 'products',
                        style: Styles.styles12w400black.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 4.w),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 2.sp,
                  indent: 20.h,
                  endIndent: 20.h,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '${_dbChangeNotifier.dbData.totalPrice} ',
                        style: Styles.styles12w500Black.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextSpan(
                        text: 'EGP',
                        style: Styles.styles12w400black.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
