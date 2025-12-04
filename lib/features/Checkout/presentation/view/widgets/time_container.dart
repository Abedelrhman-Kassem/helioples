import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/radio_animated_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/delivery_time_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class TimeScheduleContainer extends StatefulWidget {
  final String title;
  final CreateOrderModel createOrderModel;

  const TimeScheduleContainer({
    super.key,
    required this.title,
    required this.createOrderModel,
  });

  @override
  State<TimeScheduleContainer> createState() => _TimeScheduleContainerState();
}

class _TimeScheduleContainerState extends State<TimeScheduleContainer> {
  late CreateOrderCubit createOrderCubit;
  DeliveryTimeModel? deliveryTimeModel;

  @override
  void initState() {
    createOrderCubit = BlocProvider.of<CreateOrderCubit>(context);
    createOrderCubit.getDeliveryTime();
    super.initState();
  }

  String transferHours(double time) {
    if (time < 10) {
      return '0$time';
    } else {
      return time.toInt().toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) {
        if (state is GetDeliveryTimeFailed) {
          CustomSnackBar.show(
            context: context,
            text: state.error,
            duration: const Duration(seconds: 10),
            isGreen: false,
          );
        }

        if (state is GetDeliveryTimeSuccess) {
          deliveryTimeModel = state.deliveryTimeModel;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            if (state is LoadingDeliveryTime)
              Center(
                child: CircularProgressIndicator(
                  color: MyColors.mainColor,
                ),
              ),
            if (deliveryTimeModel != null)
              Container(
                padding: EdgeInsets.all(20.r),
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
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
                          widget.title,
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
                                text: LocaleKeys.schedule_screen_arrive_at.tr(),
                                style: Styles.styles12w400black,
                                children: [
                                  TextSpan(
                                    text:
                                        '${createOrderCubit.availableTime?.from!}  -  ${createOrderCubit.availableTime?.to}',
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
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                initialChildSize: 0.7,
                                minChildSize: 0.5,
                                maxChildSize: 0.9,
                                expand: false,
                                builder: (context, scrollController) {
                                  return BlocProvider<CreateOrderCubit>.value(
                                    value: createOrderCubit,
                                    child: TimeContainer(
                                      scrollController: scrollController,
                                      deliveryTimeModel: deliveryTimeModel!,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                          setState(() {
                            widget.createOrderModel.deliverTimeId =
                                createOrderCubit.availableTime!.id;
                          });
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
                              LocaleKeys.schedule_screen_schedule.tr(),
                              style: Styles.styles12w400MainColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class TimeContainer extends StatefulWidget {
  final ScrollController scrollController;
  final DeliveryTimeModel deliveryTimeModel;
  const TimeContainer({
    super.key,
    required this.scrollController,
    required this.deliveryTimeModel,
  });

  @override
  State<TimeContainer> createState() => _TimeContainerState();
}

class _TimeContainerState extends State<TimeContainer> {
  late List<AvailableTime> availableTime;
  late CreateOrderCubit createOrderCubit;
  late AvailableTime selectedTime;

  @override
  void initState() {
    availableTime = widget.deliveryTimeModel.available!;
    createOrderCubit = BlocProvider.of<CreateOrderCubit>(context);
    selectedTime = createOrderCubit.availableTime!;

    super.initState();
  }

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
                  LocaleKeys.checkout_delivery_screen_delivery_time.tr(),
                  style: Styles.styles17w700Black,
                ),
                InkWell(
                  onTap: () {
                    createOrderCubit.availableTime = selectedTime;
                    Navigator.pop(context);
                  },
                  child: Text(
                    LocaleKeys.verification_changes_screen_done.tr(),
                    style: Styles.styles14w400Black.copyWith(
                      color: const Color.fromRGBO(93, 92, 100, 1),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // radioTimeItem(
            //   title: RichText(
            //     text: TextSpan(
            //       text: 'Instant, ',
            //       style: Styles.styles12w400black.copyWith(
            //         color: Colors.black,
            //       ),
            //       children: [
            //         TextSpan(
            //           text: 'Arrive at 7:30 PM',
            //           style: Styles.styles12w400Gold,
            //         ),
            //       ],
            //     ),
            //   ),
            //   iconPath: 'hand-clock',
            //   index: 0,
            //   radioValue: radioValue,
            //   onTap: () {
            //     setState(() {
            //       radioValue = 0;
            //     });
            //   },
            // ),
            Container(
              color: const Color.fromRGBO(120, 120, 120, 1),
              width: double.infinity,
              height: 1,
              margin: EdgeInsets.symmetric(vertical: 20.h),
            ),
            Text(
              LocaleKeys.schedule_screen_schedule_delivery_time.tr(),
              style: Styles.styles12w300NormalBlack.copyWith(
                color: const Color.fromRGBO(120, 120, 120, 1),
              ),
            ),
            SizedBox(height: 20.h),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: availableTime.length,
              itemBuilder: (context, index) {
                return radioTimeItem(
                  title: Text(
                    '${availableTime[index].from!} - ${availableTime[index].to!}',
                    style: Styles.styles15w400Black.copyWith(
                      color: const Color.fromRGBO(41, 41, 41, 1),
                    ),
                  ),
                  isSelected: selectedTime.id! == availableTime[index].id!,
                  onTap: () {
                    setState(() {
                      selectedTime = availableTime[index];
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
  required bool isSelected,
  required void Function() onTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: const Color.fromRGBO(248, 147, 31, 0.1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromRGBO(248, 147, 31, 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              width: 0.5,
              color: isSelected
                  ? const Color.fromRGBO(248, 147, 31, 1)
                  : const Color.fromRGBO(150, 150, 150, 1),
            ),
          ),
          child: Row(
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
              const Spacer(),
              radioAnimatedWidget(isSelected),
            ],
          ),
        ),
      ),
    ),
  );
}
