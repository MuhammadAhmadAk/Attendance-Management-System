import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scavenger_app/utils/custom_color.dart';

class TextFormFieldWgt extends StatelessWidget {
  final double? fontSize;
  final String? hintText;
  final String? labelText;
  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? autofocus;
  final Color? fontColor;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final int? maxLength;

  final Icon? preicon;

  TextFormFieldWgt({
    Key? key,
    this.fontSize,
    this.maxLength,
    this.controller,
    this.validator,
    this.margin,
    this.height,
    this.borderRadius,
    this.padding,
    this.onChanged,
    this.fontColor,
    this.hintText,
    this.width,
    this.readOnly,
    this.labelText,
    this.autofocus = false,
    this.keyboardType,
    this.preicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: width ?? 380,
        height: height ?? 55,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          child: TextFormField(
            readOnly: readOnly ?? false,
            keyboardType: keyboardType,
            controller: controller,
            autofocus: autofocus ?? false,
            validator: validator,
            cursorColor: textColor,
            maxLength: maxLength,
            style: TextStyle(
              fontSize: fontSize ?? 16,
              color: fontColor ?? Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            cursorWidth: 1,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: labelText,
              contentPadding: EdgeInsets.all(18),
              labelStyle: TextStyle(
                  color: Colors.orange,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              hintText: hintText ?? "Enter Value",
              prefixIcon: preicon,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: fontSize ?? 14,
                fontWeight: FontWeight.w100,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              errorBorder: InputBorder.none,
              errorStyle: TextStyle(color: Colors.red, fontSize: 08),
            ),
          ),
        ));
  }
}
