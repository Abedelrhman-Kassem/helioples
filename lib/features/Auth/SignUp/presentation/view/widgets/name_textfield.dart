import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class NameTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isEnabled;
  final bool isPassword;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const NameTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isEnabled = true,
    this.isPassword = false,
    this.validator,
    this.focusNode,
  });

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(widget.labelText, style: Styles.styles14w400NormalBlack),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          focusNode: widget.focusNode,
          validator: widget.validator,
          controller: widget.controller,
          enabled: widget.isEnabled,
          obscureText: widget.isPassword ? _isObscure : false,
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
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: MyColors.mainColor,
                    ),
                  )
                : null,
          ),
          style: Styles.styles17w500NormalBlack,
        ),
      ],
    );
  }
}
