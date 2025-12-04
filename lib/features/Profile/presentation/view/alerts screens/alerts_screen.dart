import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/alerts%20cubit/alerts_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/alerts%20cubit/alerts_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
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
          child: BlocProvider(
            create: (context) =>
                AlertsCubit(ProfileRepoImp(api: ApiService()))..getAlerts(),
            child: BlocBuilder<AlertsCubit, FetchAlertsState>(
                builder: (context, state) {
              if (state is FetchAlertsLoading) {
                return const CircularProgressIndicator();
              } else if (state is FetchAlertsFailure) {
                return Center(child: Text(state.msg));
              } else if (state is FetchAlertsSuccess) {
                return Column(
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
                            LocaleKeys.alerts_screen_Alerts.tr(),
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
                                  LocaleKeys.alerts_screen_Today.tr(),
                                  style: Styles.styles13w400interFamily
                                      .copyWith(
                                          color: const Color.fromRGBO(
                                              41, 41, 41, 1)),
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
                                                LocaleKeys
                                                    .alerts_screen_Order_Confirmed_Successfully,
                                                style: Styles
                                                    .styles16w500Black36
                                                    .copyWith(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              SizedBox(
                                                width: 250.w,
                                                child: Text(
                                                  LocaleKeys
                                                      .alerts_screen_Lorem_ipsum,
                                                  style: Styles
                                                      .styles12w400intergrey121,
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
                );
              } else {
                return Container();
              }
            }),
          ),
        ),
      ),
    );
  }
}
