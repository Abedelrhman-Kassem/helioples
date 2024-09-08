import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class CompletedOrderScreen extends StatelessWidget {
  const CompletedOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 26.w),
                    child: Text(
                      "Today",
                      style: Styles.styles13w400interFamily
                          .copyWith(color: const Color.fromRGBO(41, 41, 41, 1)),
                    ),
                  ),
                  ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.h, vertical: 8.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(orderDetailsScreen);
                          },
                          child: Container(
                            width: 160.w,
                            height: 130.h,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(227, 227, 227, 1),
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        243, 243, 243, 1))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  child: Image.asset(
                                    "assets/Icons_logos/history_icon.png",
                                    width: 60.w,
                                    height: 60.h,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                                text: "12 ",
                                                style: Styles
                                                    .styles13w300interFamily
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                      text: "Items",
                                                      style: Styles
                                                          .styles13w300interFamily
                                                          .copyWith(
                                                              color: const Color
                                                                  .fromRGBO(80,
                                                                  80, 80, 1)))
                                                ]),
                                          ),
                                          SizedBox(
                                            width: 125.w,
                                          ),
                                          Text(
                                            "325.00EGP",
                                            style:
                                                Styles.styles17w700interFamily,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/svg_icons/location_history.svg"),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Text(
                                            "13 Salah Salem, No 45 Cairo Egypt",
                                            style: Styles
                                                .styles12w400interFamily
                                                .copyWith(
                                                    color: const Color.fromRGBO(
                                                        80, 80, 80, 1)),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/Icons_logos/logos_visa.png"),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Text(
                                            "***521",
                                            style: Styles
                                                .styles11w700interFamily
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
