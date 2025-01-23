import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/problem_page.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_states.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../data/repo/order%20history%20repo/order_history_repo_imp.dart';

class CompletedOrderScreen extends StatefulWidget {
  const CompletedOrderScreen({super.key});

  @override
  _CompletedOrderScreenState createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {
  late ScrollController _scrollController;
  late HistoryCubit _historyCubit;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Initialize and fetch history when the screen initializes
    _historyCubit = HistoryCubit(OrderHistoryRepoImp(api: ApiService()));
    _historyCubit.fetchHistory('OnWay');

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _historyCubit.fetchHistory('OnWay');
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _historyCubit,
      child: BlocBuilder<HistoryCubit, FetchHistoryState>(
        builder: (context, state) {
          if (state is FetchHistoryLoading &&
              _historyCubit.orderHistoryList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchHistoryFailure) {
            if(state.msg == "You are not allowed to access this page.")
            {
               return Center(child: InfoMessageWidget(
              buttonText: "Sign In Now",
              imagePath: "assets/Icons_logos/Social 03.png",
              title: "No Profile Information",
              description: "You need sign in to app in order to control your personal information",
              onPressed: (){
                Navigator.pushNamed(context,signInScreen );
              },

            ));
              
            } else 
            {
              return Center(child: InfoMessageWidget(
              buttonText: "Refresh",
              imagePath: "assets/Icons_logos/Connectivity_issue.png",
              title: "Error Occurred",
              description: "Seems like we got a problem, please refresh",
              onPressed: (){
                Navigator.pushNamed(context,signInScreen );
              },

            ));

            }
           
          } else if (state is FetchHistorySuccess ||
              _historyCubit.orderHistoryList.isNotEmpty) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: _historyCubit.orderHistoryList.length + 1,
              itemBuilder: (context, index) {
                if (index == _historyCubit.orderHistoryList.length) {
                  return _historyCubit.isFetching
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox.shrink();
                }

                
                var orderHistory = _historyCubit.orderHistoryList[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   
                      Text(
                        orderHistory.date ?? '',
                        style: Styles.styles17w700interFamily.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      Column(
                        children: orderHistory.orders?.map((order) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(orderDetailsScreen , arguments: {
                                          'order' : order,
                                        });
                                  },
                                  child: Container(
                                    width: 400.w,
                                    height: 130.h,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          227, 227, 227, 1),
                                      borderRadius: BorderRadius.circular(30.r),
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            243, 243, 243, 1),
                                      ),
                                    ),
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
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      text: "${order.userId} ",
                                                      style: Styles
                                                          .styles13w300interFamily
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                      children: [
                                                        TextSpan(
                                                          text: "Items",
                                                          style: Styles
                                                              .styles13w300interFamily
                                                              .copyWith(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      80,
                                                                      80,
                                                                      80,
                                                                      1)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 125.w),
                                                  Text(
                                                    "${order.total!.toStringAsFixed(2)} EGP",
                                                    style: Styles
                                                        .styles17w700interFamily,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8.h),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "assets/svg_icons/location_history.svg"),
                                                  SizedBox(width: 6.w),
                                                  Text(
                                                    "13 Salah Salem, No 45 Cairo Egypt",
                                                    style: Styles
                                                        .styles12w400interFamily
                                                        .copyWith(
                                                            color: const Color
                                                                .fromRGBO(
                                                                80, 80, 80, 1)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8.h),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/Icons_logos/logos_visa.png"),
                                                  SizedBox(width: 6.w),
                                                  Text(
                                                    "***521",
                                                    style: Styles
                                                        .styles11w700interFamily
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13.sp),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList() ??
                            [],
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

Widget historyShimmerLoading()
{
  return Skeletonizer(
    child: Container(
      color: Colors.white,
      child: Column(
        children: [

          AppBar(
            leading:  const Icon(Icons.add_ic_call_outlined),
            title:  const Text("dummy "),
          ),
          SizedBox(
            height: 15.h,
          ),

          Row(
            children: [
              Container(
                    height: 50.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
            ],
          )
    
        ],
      ),
    ),
  );
}
