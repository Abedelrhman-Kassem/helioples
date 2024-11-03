import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  final DbChangeNotifier _dbChangeNotifier = DbChangeNotifier();

  @override
  void initState() {
    super.initState();

    _dbChangeNotifier.fetchItemCount();
    _dbChangeNotifier.addListener(refreshState);
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
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, cartScreen);
      },
      icon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SizedBox(
          width: 40.w,
          height: 50.h,
          child: Stack(
            children: [
              Positioned(
                top: 10.h,
                child: svgIcon(
                  path: 'assets/svg_icons/favorite-Cart.svg',
                  width: 35.w,
                  height: 35.h,
                  color: const Color.fromRGBO(41, 45, 50, 1),
                ),
              ),
              Positioned(
                right: 5.w,
                top: 5.h,
                child: Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(228, 144, 42, 1),
                  ),
                  child: Center(
                    child: Text(
                      "${_dbChangeNotifier.dbData.count}",
                      style: Styles.styles11w600White.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
