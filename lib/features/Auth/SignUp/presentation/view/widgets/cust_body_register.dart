import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/validate.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/name_textfield.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class CustBodyRegister extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final FocusNode? nameFocusNode;
  final FocusNode? lastNameFocusNode;

  const CustBodyRegister({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    this.nameFocusNode,
    this.lastNameFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: NameTextField(
            focusNode: nameFocusNode,
            validator: (val) {
              return vlidateInPut(
                val: val!.trim(),
                min: 3,
                max: 30,
                type: ValidateInput.username,
              );
            },
            labelText: StringTranslateExtension(
              LocaleKeys.signup_screen_first_name,
            ).tr(),
            controller: firstNameController,
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: NameTextField(
            focusNode: lastNameFocusNode,
            validator: (val) {
              return vlidateInPut(
                val: val!.trim(),
                min: 3,
                max: 30,
                type: ValidateInput.username,
              );
            },
            labelText: StringTranslateExtension(
              LocaleKeys.signup_screen_last_name,
            ).tr(),
            controller: lastNameController,
          ),
        ),
      ],
    );
  }
}
