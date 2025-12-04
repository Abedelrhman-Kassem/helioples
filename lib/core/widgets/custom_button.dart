import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.borderd = true,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.horizontalPadding,
    this.verticalPadding,
    required this.onTap,
    this.fontSize = 15,
    this.borderWidth,
    this.icon,
    this.filled,
    this.borderColor,
    this.textStyle,
    this.borderRadius,
  });
  final TextStyle? textStyle;
  final Widget? icon;
  final String? text;
  final bool? borderd;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final VoidCallback onTap;
  final double? fontSize;
  final double? borderWidth;
  final double? borderRadius;
  final bool? filled;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          color: filled != false ? backgroundColor : null,
          border: borderd == true
              ? Border.all(
                  width: borderWidth ?? 0,
                  color: borderColor ?? Colors.grey.shade500,
                )
              : null,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical: verticalPadding ?? 10,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (text != null)
                Flexible(
                  child: Text(
                    text!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize ?? 15,
                        ),
                  ),
                ),
              if (icon != null)
                Row(
                  children: [
                    if (text != null) const SizedBox(width: 10),
                    icon!,
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
