import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/validate.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/egypt_code_widget.dart';

class PhoneNumberWidget extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final FocusNode? phoneFocusNode;
  const PhoneNumberWidget({
    super.key,
    required this.phoneNumberController,
    this.phoneFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const EgyptionCodeWidget(),
        SizedBox(width: 10.w),
        Expanded(
          child: TextFormField(
            focusNode: phoneFocusNode,
            validator: (value) {
              return vlidateInPut(
                val: value!,
                min: 11,
                max: 11,
                type: ValidateInput.phoneNumber,
              );
            },
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(246, 246, 246, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(210, 210, 210, 1),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(210, 210, 210, 1),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(210, 210, 210, 1),
                  width: 1.5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
            style: Styles.styles17w500NormalBlack,
          ),
        ),
      ],
    );
  }
}
