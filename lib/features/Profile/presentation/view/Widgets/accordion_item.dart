import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class AccordionItem extends StatefulWidget {
  final String title;
  final String content;

  const AccordionItem({super.key, required this.title, required this.content});

  @override
  State<AccordionItem> createState() => _AccordionItemState();
}

class _AccordionItemState extends State<AccordionItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Container(
        decoration: BoxDecoration(
          color: !_isExpanded
              ? const Color.fromRGBO(240, 240, 240, 1)
              : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.sp,
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2.sp,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            trailing: _isExpanded
                ? Image.asset(
                    "assets/Icons_logos/faqs_buttom_arrow.png",
                    height: 40.h,
                    width: 40.w,
                  )
                : Image.asset(
                    "assets/Icons_logos/faqs_buttom_top.png",
                    height: 40.h,
                    width: 40.w,
                  ),
            title: Text(
              widget.title,
              style: Styles.styles14w600Black.copyWith(
                color: const Color.fromRGBO(20, 20, 20, 1),
              ),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.content,
                      style: Styles.styles16w400Black,
                    ),
           
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}