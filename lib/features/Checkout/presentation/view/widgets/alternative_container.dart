import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/radio_item.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/choose_bottom_sheet.dart';

class AlternativeContainer extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const AlternativeContainer({super.key, required this.createOrderModel});

  @override
  State<AlternativeContainer> createState() => _AlternativeContainerState();
}

class _AlternativeContainerState extends State<AlternativeContainer> {
  late String radioValue;

  @override
  void initState() {
    radioValue = 'call';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.createOrderModel.alternativeProduct = radioValue;

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
            'Alternative Products',
            style: Styles.styles17w700Black,
          ),
          SizedBox(height: 10.h),
          Text(
            'In case we missed one or more of chosen products, how could we reach you?',
            style: Styles.styles12w300NormalBlack.copyWith(
              color: const Color.fromRGBO(120, 120, 120, 1),
            ),
          ),
          SizedBox(height: 10.h),
          radioItem(
            title: 'Give me a call',
            iconPath: 'call',
            index: 'call',
            radioValue: radioValue,
            onTap: () async {
              setState(() {
                radioValue = 'call';
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
            title: 'WhatsApp me',
            iconPath: 'whatsapp',
            index: 'whatsapp',
            radioValue: radioValue,
            onTap: () async {
              setState(() {
                radioValue = 'whatsapp';
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
