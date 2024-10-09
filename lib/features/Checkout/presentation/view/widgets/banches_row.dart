import 'package:flutter/material.dart';
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

  int selectedBranch = 1;

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
          Text(
            "PickUp Branch",
            style: Styles.styles17w700Black
                .copyWith(color: const Color.fromRGBO(41, 41, 41, 1)),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              branchItem(
                isSelected: 1 == selectedBranch,
                onTap: () {
                  setState(
                    () {
                      selectedBranch = 1;
                    },
                  );
                },
              ),
              branchItem(
                isSelected: 2 == selectedBranch,
                onTap: () {
                  setState(
                    () {
                      selectedBranch = 2;
                    },
                  );
                },
              ),
              branchItem(
                isSelected: 3 == selectedBranch,
                onTap: () {
                  setState(
                    () {
                      selectedBranch = 3;
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget branchItem({
  required void Function() onTap,
  required bool isSelected,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/Icons_logos/bracnh_image.png",
          width: 125.w,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            svgIcon(
              path: "assets/svg_icons/branch_icon.svg",
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
              width: 50.w,
              height: 50.h,
            ),
            SizedBox(height: 5.h),
            Text(
              'Eldabaa Branch',
              style: Styles.styles11w600White,
            ),
          ],
        ),
      ],
    ),
  );
}
