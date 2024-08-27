import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380.h,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: Colors.white,
            ),
            padding: EdgeInsets.only(bottom: 100.h), // Adjust the padding to ensure no overlap
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg_icons/noto_crown.svg",
                        width: 40.w,
                        height: 40.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Featured",
                            style: Styles.styles21w700black,
                          ),
                          Text(
                            "Our Best Products From Best Partners",
                            style: Styles.styles12w400interFamily.copyWith(
                              color: const Color.fromRGBO(41, 45, 50, 1),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/Icons_logos/arrow-circle-right.png",
                        height: 25.h,
                        width: 25.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Image.asset(
                  "assets/Icons_logos/سبيرو سباتس مشروب مصري 1.png",
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 260.h,
              child: Padding(
                padding:  EdgeInsetsDirectional.fromSTEB(16.0.w, 0.0, 0.0, 0.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 10.h),
                      child: SizedBox(
                        height: 180.h,
                        width: 140.w,
                        child: Container(
                          
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 6.0),
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5.0.sp,
                              )
                            ]
                          ),
                          child: ItemWidget(color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
