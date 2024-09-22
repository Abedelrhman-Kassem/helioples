import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
// import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/alert_row.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  // List<AlertRow> alerts = [
  //   AlertRow(imagePath: , title: title, description: description)
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              start: 16.w, end: 16.w, top: 60.h, bottom: 10.h),
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    returnArrow(
                        context: context,
                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                    SizedBox(
                      width: 125.w,
                    ),
                    Text(
                      "Alerts",
                      style: Styles.styles16w400Black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.h,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.h, horizontal: 26.w),
                          child: Text(
                            "Today",
                            style: Styles.styles13w400interFamily.copyWith(
                                color: const Color.fromRGBO(41, 41, 41, 1)),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsetsDirectional.only(
                                    end: 16.w, bottom: 16.h),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/Icons_logos/alerts_icon.png",
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order Confirmed Successfully",
                                          style: Styles.styles16w500Black36
                                              .copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 250.w,
                                          child: Text(
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                            style:
                                                Styles.styles12w400intergrey121,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
