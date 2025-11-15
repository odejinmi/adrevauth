import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextStyle? style;
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? textColor;
  const CustomText({
    this.textAlign,
    this.fontFamily,
    this.fontWeight,
    this.textColor,
    this.fontSize,
    this.text,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text!,
      style: TextStyle(
          fontSize: fontSize ?? 15,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: textColor ?? Colors.black,
          fontFamily: fontFamily ?? 'GROBOLD'),
    );
  }
}



class HeaderText extends StatelessWidget {
  final TextStyle? style;
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? textColor;
  const HeaderText({
    this.textAlign,
    this.fontFamily,
    this.fontWeight,
    this.textColor,
    this.fontSize,
    this.text,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text!,
      style: TextStyle(
          fontSize: fontSize ?? 18,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: textColor ?? Colors.black,
          fontFamily: fontFamily ?? 'Nunito Sans'),
    );
  }
}

