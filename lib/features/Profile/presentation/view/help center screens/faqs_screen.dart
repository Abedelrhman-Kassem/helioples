import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(
            start: 16.w, end: 16.w, top: 60.h, bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                returnArrow(
                  context: context,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 125.w,
                ),
                Text(
                  "FAQS",
                  style: Styles.styles16w400Black,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView(
                children: const [
                  AccordionItem(
                    title: "What is the purpose of this app?",
                    content:
                        "This App help you with home grocery ",
                  ),
                  AccordionItem(
                    title: "How do I make an order?",
                    content:
                        "You can make an order by selecting your preferred products, date, and time, then confirming the details.",
                  ),
                  AccordionItem(
                    title: "Can I cancel my orders?",
                    content:
                        "Yes, orders can be canceled  before the scheduled time.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

