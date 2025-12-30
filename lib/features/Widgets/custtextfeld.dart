import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';

class Custtextfeld extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FocusNode? focusNode;

  const Custtextfeld({
    super.key,
    required this.hint,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.obscureText,
    this.onChanged,
    this.onTap,
    this.maxLines,
    this.minLines,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 50),
        child: TextFormField(
          autofocus: false,
          focusNode: focusNode,
          onTap: onTap,
          maxLines: maxLines ?? 1,
          minLines: minLines ?? 1,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          validator: validator,
          controller: controller,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: MyColors.mainColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.8),
            suffixIcon: suffixIcon,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            errorMaxLines: 2,
          ),
        ),
      ),
    );
  }
}
