import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Notification/data/repo/notification_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/notification.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/alerts%20cubit/alerts_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/alerts%20cubit/alerts_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:negmt_heliopolis/core/widgets/pagination_listener.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  Map<String, List<Alerts>> _groupNotifications(List<Alerts> alerts) {
    Map<String, List<Alerts>> grouped = {};
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    for (var alert in alerts) {
      if (alert.createdAt == null) continue;
      DateTime createdDate = DateTime.parse(alert.createdAt!);
      DateTime dateOnly = DateTime(
        createdDate.year,
        createdDate.month,
        createdDate.day,
      );

      String key;
      if (dateOnly == today) {
        key = LocaleKeys.alerts_screen_Today.tr();
      } else if (dateOnly == yesterday) {
        key = LocaleKeys.alerts_screen_Yesterday.tr();
      } else {
        key = DateFormat('yyyy-MM-dd').format(createdDate);
      }

      if (grouped.containsKey(key)) {
        grouped[key]!.add(alert);
      } else {
        grouped[key] = [alert];
      }
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => NotificationRepoImp(api: ApiService()),
        child: Builder(
          builder: (context) {
            return BlocProvider(
              create: (context) => AlertsCubit(
                RepositoryProvider.of<NotificationRepoImp>(context),
              )..getAlerts(),
              child: BlocBuilder<AlertsCubit, FetchAlertsState>(
                builder: (context, state) {
                  bool isLoading = state is FetchAlertsLoading;
                  List<Alerts> displayAlerts = [];
                  bool isPaginationLoading = false;

                  if (state is FetchAlertsSuccess) {
                    displayAlerts = state.alerts;
                    isPaginationLoading = state.isPaginationLoading;
                  } else if (isLoading) {
                    displayAlerts = List.generate(
                      9,
                      (index) => Alerts(
                        title: "Notification Title Mock",
                        description:
                            "Mock description for the alert item goes here",
                        createdAt: DateTime.now().toString(),
                        isRead: true,
                      ),
                    );
                  }

                  final grouped = _groupNotifications(displayAlerts);

                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 16.w,
                      top: 60.h,
                      bottom: 10.h,
                    ),
                    child: Skeletonizer(
                      enabled: isLoading,
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
                              const Spacer(),
                              Text(
                                LocaleKeys.alerts_screen_Alerts.tr(),
                                style: Styles.styles16w400Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(width: 40.w),
                            ],
                          ),
                          if (state is FetchAlertsFailure)
                            Center(child: Text(state.msg))
                          else if (displayAlerts.isEmpty && !isLoading)
                            Center(
                              child: Text(LocaleKeys.alerts_screen_Alerts.tr()),
                            )
                          else
                            Expanded(
                              child: PaginationListener(
                                isLoading: isPaginationLoading,
                                onLoadMore: () {
                                  context.read<AlertsCubit>().loadMore();
                                },
                                child: ListView.builder(
                                  itemCount:
                                      grouped.keys.length +
                                      (isPaginationLoading ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == grouped.keys.length) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Helper.loadingWidget(),
                                        ),
                                      );
                                    }

                                    String key = grouped.keys.elementAt(index);
                                    List<Alerts> items = grouped[key]!;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.h,
                                          ),
                                          child: Text(
                                            key,
                                            style: Styles
                                                .styles13w400interFamily
                                                .copyWith(
                                                  color: const Color(
                                                    0xFF6D6D6D,
                                                  ),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: items.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 16.h),
                                          itemBuilder: (context, idx) {
                                            final alert = items[idx];
                                            return InkWell(
                                              onTap: () {
                                                if (alert.isRead == false &&
                                                    alert.id != null) {
                                                  context
                                                      .read<AlertsCubit>()
                                                      .markNotificationAsRead(
                                                        alert.id!,
                                                      );
                                                }
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 56.h,
                                                    width: 56.w,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Color(
                                                            0xFFF1F4F5,
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: Center(
                                                      child:
                                                          alert.icon != null &&
                                                              alert
                                                                  .icon!
                                                                  .isNotEmpty
                                                          ? CachedNetworkImage(
                                                              imageUrl:
                                                                  alert.icon!,
                                                              height: 30.h,
                                                              width: 30.w,
                                                              errorWidget:
                                                                  (
                                                                    context,
                                                                    url,
                                                                    error,
                                                                  ) => Image.asset(
                                                                    "assets/Icons_logos/alerts_icon.png",
                                                                    height:
                                                                        30.h,
                                                                    width: 30.w,
                                                                  ),
                                                            )
                                                          : Image.asset(
                                                              "assets/Icons_logos/alerts_icon.png",
                                                              height: 30.h,
                                                              width: 30.w,
                                                            ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 16.w),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          alert.title ??
                                                              "No Title",
                                                          style: Styles
                                                              .styles16w500Black36
                                                              .copyWith(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        SizedBox(height: 4.h),
                                                        Text(
                                                          alert.description ??
                                                              "No Description",
                                                          style: Styles
                                                              .styles12w400intergrey121
                                                              .copyWith(
                                                                color:
                                                                    const Color(
                                                                      0xFF8E8E8E,
                                                                    ),
                                                                fontSize: 14.sp,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 16.h),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
