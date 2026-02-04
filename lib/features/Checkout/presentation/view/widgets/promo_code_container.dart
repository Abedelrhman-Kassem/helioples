import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class PromoCodeContainer extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const PromoCodeContainer({super.key, required this.createOrderModel});

  @override
  State<PromoCodeContainer> createState() => _PromoCodeContainerState();
}

class _PromoCodeContainerState extends State<PromoCodeContainer> {
  TextEditingController promoCodeController = .new();
  final DbChangeNotifier dbChangeNotifier = DbChangeNotifier();
  final FocusNode focusNode = .new();

  @override
  void dispose() {
    promoCodeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) {
        if (state is CheckPromoCodeFailed) {
          showCustomGetSnack(isGreen: false, text: state.error);
        }

        if (state is CheckPromoCodeSuccess) {
          widget.createOrderModel.promoCodeId = state.promoCodeModel.data!.id;
          focusNode.unfocus();
        }
      },
      builder: (context, state) {
        var createOrderCubit = BlocProvider.of<CreateOrderCubit>(context);

        return Container(
          padding: EdgeInsets.all(20.r),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.order_summary_screen_title.tr(),
                style: Styles.styles17w700Black,
              ),
              SizedBox(height: 20.h),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33.06.r),
                  border: Border.all(
                    color: const Color.fromRGBO(246, 246, 246, 1),
                  ),
                ),
                child: TextField(
                  focusNode: focusNode,
                  controller: promoCodeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 15.h,
                    ),
                    hintText: LocaleKeys.order_summary_screen_hint.tr(),
                    border: InputBorder.none,
                    hintStyle: Styles.styles17w400interFamily.copyWith(
                      color: const Color.fromRGBO(181, 185, 190, 1),
                    ),
                    suffixIcon: state is CheckPromoCodeLoading
                        ? Container(
                            height: 50.h,
                            width: 50.h,
                            padding: EdgeInsets.all(10.r),
                            child: CircularProgressIndicator(
                              color: MyColors.mainColor,
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              if (promoCodeController.text.isNotEmpty) {
                                createOrderCubit.checkPromoCode(
                                  promoCodeController.text,
                                  dbChangeNotifier.dbData.totalPrice,
                                );
                              }
                            },
                            child: Text(
                              LocaleKeys.order_summary_screen_apply_button.tr(),
                              style: Styles.styles17w500MainColor,
                            ),
                          ),
                  ),
                  cursorColor: MyColors.mainColor,
                  style: Styles.styles17w700MainColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
