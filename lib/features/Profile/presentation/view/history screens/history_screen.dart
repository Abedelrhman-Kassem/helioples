import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/history%20screens/active_orders_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/history%20screens/completed_order_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(180.h),
              child: Builder(builder: (context) {
                return SizedBox(
                  height: 150.h,
                  width: double.infinity,
                  child: AppBar(
                    toolbarHeight: 200.h,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    leading: returnArrow(context: context, onTap: (){
                Navigator.of(context).pop();
              }),
                    title: Text(
                      "Orders History",
                      style: Styles.styles16w400grey.copyWith(color: Colors.black),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(65.h),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ButtonsTabBar(
                            borderColor: Colors.transparent,
                            unselectedBorderColor: const  Color.fromRGBO(238, 238, 238, 1),
                            borderWidth: 1.sp,
                            radius: 25.r,
                            contentCenter: true,
                            buttonMargin: EdgeInsets.all(10.sp),
                            labelSpacing: 10.sp,
                            contentPadding: EdgeInsets.all(8.sp),
                            splashColor: MyColors.mainColor,
                            height: 65.h,
                            backgroundColor: MyColors.mainColor,
                            unselectedBackgroundColor:const  Color.fromRGBO(238, 238, 238, 1),
                            labelStyle: Styles.styles16w400grey
                                .copyWith(color: Colors.white),
                            unselectedLabelStyle: Styles.styles16w400grey
                                .copyWith(color: Colors.black),
                            tabs: const  [
                              Tab(
                                text: "Active Orders",
                              ),
                              Tab(text: "Completed Orders",)
                          
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                );
              })) ,
               body: const TabBarView(children: [
                ActiveOrdersScreen(),
                CompletedOrderScreen(),
      
               ]),
              ),
    );
    
  }
}
