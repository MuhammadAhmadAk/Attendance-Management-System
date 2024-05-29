import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scavenger_app/utils/custom_color.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final double? buttonWidth;
  final String? text;
  final double? buttonHeight;
  final double? buttonElevation;
  final Color? buttonBackgroundColor;
  final Color? textColor;
  final double? buttonborderRadius;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Gradient? gradient;

  const CustomButtonWidget({
    Key? key,
    required this.onPressed,
    this.margin,
    this.buttonBackgroundColor,
    this.buttonWidth,
    this.buttonElevation,
    this.buttonHeight,
    this.buttonborderRadius,
    this.fontSize,
    this.fontWeight,
    this.text,
    this.textColor,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth ?? 330.w,
      height: buttonHeight ?? 44.h,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 13.w),
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
        borderRadius: BorderRadius.circular(buttonborderRadius ?? 8.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: buttonElevation ?? 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(buttonborderRadius ?? 8.0),
          ),
          backgroundColor: Colors.transparent, // Set background to transparent
          shadowColor: Colors.transparent, // Ensure no shadow is rendered
        ),
        child: Text(
          text ?? "Text",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize ?? 15.sp,
            fontWeight: fontWeight ?? FontWeight.w700,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
