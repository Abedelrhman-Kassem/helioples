import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/radio_item.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/choose_bottom_sheet.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class AlternativeContainer extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const AlternativeContainer({super.key, required this.createOrderModel});

  @override
  State<AlternativeContainer> createState() => _AlternativeContainerState();
}

class _AlternativeContainerState extends State<AlternativeContainer> {
  late AlternativeProductType radioValue;

  @override
  void initState() {
    radioValue = AlternativeProductType.call;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.createOrderModel.alternativeProduct = radioValue;
    widget.createOrderModel.chooseForMe = true;

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
            LocaleKeys.alternative_container_alternative_products.tr(),
            style: Styles.styles17w700Black,
          ),
          SizedBox(height: 10.h),
          Text(
            LocaleKeys.alternative_container_alternative_description.tr(),
            style: Styles.styles12w300NormalBlack.copyWith(
              color: const Color.fromRGBO(120, 120, 120, 1),
            ),
          ),
          SizedBox(height: 10.h),
          radioItem(
            title: LocaleKeys.alternative_container_give_me_a_call.tr(),
            iconPath: 'call',
            index: 'call',
            radioValue: radioValue.toApiString(),
            onTap: () async {
              setState(() {
                radioValue = AlternativeProductType.call;
              });
              return showModalBottomSheet(
                context: context,
                builder: (context) => ChooseBottomSheet(
                  createOrderModel: widget.createOrderModel,
                ),
              );
            },
          ),
          radioItem(
            title: LocaleKeys.alternative_container_remove_item.tr(),
            iconPath: 'trash',
            index: 'remove',
            radioValue: radioValue.toApiString(),
            onTap: () async {
              setState(() {
                radioValue = AlternativeProductType.remove;
              });
              return showModalBottomSheet(
                context: context,
                builder: (context) => ChooseBottomSheet(
                  createOrderModel: widget.createOrderModel,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
