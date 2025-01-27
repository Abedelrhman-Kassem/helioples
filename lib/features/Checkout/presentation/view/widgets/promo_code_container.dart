import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';

class PromoCodeContainer extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const PromoCodeContainer({
    super.key,
    required this.createOrderModel,
  });

  @override
  State<PromoCodeContainer> createState() => _PromoCodeContainerState();
}

class _PromoCodeContainerState extends State<PromoCodeContainer> {
  TextEditingController promoCodeController = TextEditingController();

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) {
        if (state is CheckPromoCodeFailed) {
          CustomSnackBar.show(
            context: context,
            duration: const Duration(seconds: 10),
            text: state.error,
            isGreen: false,
          );
        }

        if (state is CheckPromoCodeSuccess) {
          widget.createOrderModel.promoCode =
              state.promoCodeModel.promoCode!.code;
        }
      },
      builder: (context, state) {
        var createOrderCubit = BlocProvider.of<CreateOrderCubit>(context);

        return Container(
          padding: EdgeInsets.all(20.r),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Promo code',
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
                  controller: promoCodeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 15.h,
                    ),
                    hintText: 'Enter Promo code',
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
                                createOrderCubit
                                    .checkPromoCode(promoCodeController.text);
                              }
                            },
                            child: Text(
                              'Apply',
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
