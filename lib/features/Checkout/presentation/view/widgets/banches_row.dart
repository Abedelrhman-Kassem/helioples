import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class BranchesRow extends StatefulWidget {
  const BranchesRow({
    super.key,
  });

  @override
  State<BranchesRow> createState() => _BranchesRowState();
}

class _BranchesRowState extends State<BranchesRow> {
  Color color1 = Colors.grey;
  Color color2 = Colors.grey;
  Color color3 = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("PickUp Branch" ,
          style: Styles.styles17w700Black.copyWith(color:  const Color.fromRGBO(41,41,41, 1)),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  color1 = Colors.white;
                  color2 = Colors.grey;
                  color3 = Colors.grey;
                  setState(() {});
                },
                child: Stack(
                  children: [
                    Image.asset("assets/Icons_logos/bracnh_image.png"),
                    Positioned(
                      left: 36.w,
                      top: 30.h,
                      child: svgIcon(
                          path: "assets/svg_icons/branch_icon.svg",
                          color: color1,
                          width: 50.w,
                          height: 50.h),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () {
                  color1 = Colors.grey;
                  color2 = Colors.white;
                  color3 = Colors.grey;
                  setState(() {});
                },
                child: Stack(
                  children: [
                    Image.asset("assets/Icons_logos/bracnh_image.png"),
                    Positioned(
                      left: 36.w,
                      top: 30.h,
                      child: svgIcon(
                          path: "assets/svg_icons/branch_icon.svg",
                          color: color2,
                          width: 50.w,
                          height: 50.h),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () {
                  color1 = Colors.grey;
                  color2 = Colors.grey;
                  color3 = Colors.white;
                  setState(() {});
                },
                child: Stack(
                  children: [
                    Image.asset("assets/Icons_logos/bracnh_image.png"),
                    Positioned(
                      left: 36.w,
                      top: 30.h,
                      child: svgIcon(
                          path: "assets/svg_icons/branch_icon.svg",
                          color: color3,
                          width: 50.w,
                          height: 50.h),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
