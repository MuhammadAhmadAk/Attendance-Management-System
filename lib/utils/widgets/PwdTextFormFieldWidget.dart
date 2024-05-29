import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scavenger_app/utils/custom_color.dart';

class PwdTextFormFieldWidget extends StatefulWidget {
  final double? fontSize;
  final String? hintText;
  final double? height;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? autofocus;
  final Color? fontColor;
  final double? width;
  final String? labelText;

  final void Function(String)? onChanged;
  PwdTextFormFieldWidget({
    Key? key,
    this.fontSize,
    this.height,
    this.controller,
    this.validator,
    this.onChanged,
    this.fontColor,
    this.hintText,
    this.width,
    this.labelText,
    this.autofocus = false,
  }) : super(key: key);

  @override
  State<PwdTextFormFieldWidget> createState() => _PwdTextFormFieldWidgetState();
}

class _PwdTextFormFieldWidgetState extends State<PwdTextFormFieldWidget> {
  bool isPaasword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: widget.width ?? 380,
        height: widget.height ?? 55,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          child: TextFormField(
            controller: widget.controller,
            autofocus: widget.autofocus ?? false,
            validator: widget.validator,
            cursorColor: textColor,
            obscureText: isPaasword,
            style: TextStyle(
              fontSize: widget.fontSize ?? 16,
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            cursorWidth: 1,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isPaasword = !isPaasword;
                  });
                },
                child: Icon(
                  isPaasword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: isPaasword ? Colors.grey : Colors.white,
                  size: 24,
                ),
              ),
              contentPadding: EdgeInsets.all(18),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: Colors.orange,
                fontSize: 14,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: widget.hintText ?? "Enter Value",
              prefixIcon: Icon(
                Icons.vpn_key_outlined,
                size: 20,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
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
