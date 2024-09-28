import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

Widget timeScheduleContainer(BuildContext context , String title) {
  return Container(
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
              title,
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
            onTap: () async {
              return await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.7,
                    minChildSize: 0.5,
                    maxChildSize: 0.9,
                    expand: false,
                    builder: (context, scrollController) {
                      return TimeContainer(scrollController: scrollController);
                    },
                  );
                },
              );
            },
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
  );
}

class TimeContainer extends StatefulWidget {
  final ScrollController scrollController;
  const TimeContainer({super.key, required this.scrollController});

  @override
  State<TimeContainer> createState() => _TimeContainerState();
}

class _TimeContainerState extends State<TimeContainer> {
  int radioValue = 0;

  List<String> timeList = [
    '7:00 PM - 8:00 PM',
    '8:00 PM - 9:00 PM',
    '9:00 PM - 10:00 PM',
    '10:00 PM - 11:00 PM',
    '11:00 PM - 12:00 AM',
    '1:00 AM - 2:00 AM',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Time',
                  style: Styles.styles17w700Black,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: Styles.styles14w400Black.copyWith(
                      color: const Color.fromRGBO(93, 92, 100, 1),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            radioTimeItem(
              title: RichText(
                text: TextSpan(
                  text: 'Instant, ',
                  style: Styles.styles12w400black.copyWith(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Arrive at 7:30 PM',
                      style: Styles.styles12w400Gold,
                    ),
                  ],
                ),
              ),
              iconPath: 'hand-clock',
              index: 0,
              radioValue: radioValue,
              onTap: () {
                setState(() {
                  radioValue = 0;
                });
              },
            ),
            Container(
              color: const Color.fromRGBO(120, 120, 120, 1),
              width: double.infinity,
              height: 1,
              margin: EdgeInsets.symmetric(vertical: 20.h),
            ),
            Text(
              'Schedule delivery time',
              style: Styles.styles12w300NormalBlack.copyWith(
                color: const Color.fromRGBO(120, 120, 120, 1),
              ),
            ),
            SizedBox(height: 20.h),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: timeList.length,
              itemBuilder: (context, index) {
                return radioTimeItem(
                  title: Text(
                    timeList[index],
                    style: Styles.styles15w400Black.copyWith(
                      color: const Color.fromRGBO(41, 41, 41, 1),
                    ),
                  ),
                  index: index + 1,
                  radioValue: radioValue,
                  onTap: () {
                    setState(() {
                      radioValue = index + 1;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget radioTimeItem({
  required Widget title,
  String? iconPath,
  required int index,
  required int radioValue,
  required void Function() onTap,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: radioValue == index
          ? const Color.fromRGBO(248, 147, 31, 0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(
        width: 0.5,
        color: radioValue == index
            ? const Color.fromRGBO(248, 147, 31, 1)
            : const Color.fromRGBO(150, 150, 150, 1),
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: const Color.fromRGBO(248, 147, 31, 0.1),
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconPath is String) ...[
                svgIcon(
                  path: 'assets/svg_icons/$iconPath.svg',
                  width: 18.w,
                  height: 18.h,
                  color: const Color.fromRGBO(41, 41, 41, 1),
                ),
                SizedBox(width: 5.w),
              ],
              title,
            ],
          ),
          trailing: AnimatedContainer(
            width: 17.w,
            height: 17.h,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle, // To make it look like a radio button
              border: Border.all(
                color: radioValue == index
                    ? const Color.fromRGBO(248, 147, 31, 1)
                    : const Color.fromRGBO(150, 150, 150, 1),
                width: 0.88.r,
              ),
            ),
            child: Align(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 6.38.w,
                height: 6.38.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: radioValue == index
                      ? const Color.fromRGBO(248, 147, 31, 1)
                      : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
