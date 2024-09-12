import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class InvoiceItem extends StatelessWidget {
  final String title;
  final String value;


  const InvoiceItem({
    super.key,
    required this.title,
    required this.value,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style:  Styles.styles14w500intergrey121,
        ),
        const Spacer(),
        Text(
          value,
          style: Styles.styles14w500interBlack36,
        ),
      ],
    );
  }
}
