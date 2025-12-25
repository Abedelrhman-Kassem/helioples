import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingOfferWiget extends StatelessWidget {
  final double height;
  final double width;
  const LoadingOfferWiget({super.key, this.height = 130, this.width = 275});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        width: width.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: SizedBox(
                width: width.w,
                height: height.h,
                child: Helper.loadNetworkImage(
                  assetsErrorPath: 'assets/test_images/home_categories.png',
                ),
              ),
            ),
            const Text('Hi There'),
            const Text('Nice To Meet You'),
          ],
        ),
      ),
    );
  }
}
