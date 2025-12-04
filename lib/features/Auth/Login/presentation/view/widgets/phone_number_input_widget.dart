import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/egypt_code_widget.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class PhoneNumberInputWidget extends StatelessWidget {
  const PhoneNumberInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const EgyptionCodeWidget(),
        const Gap(13),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(239, 239, 239, 1),
              filled: true,
              border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black87, width: 10),
                  borderRadius: BorderRadius.circular(30)),
              labelText: LocaleKeys.login_screen_phone_number.tr(),
            ),
          ),
        ),
      ],
    );
  }
}
