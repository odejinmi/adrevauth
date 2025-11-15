import 'package:adrevauth/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  final Widget? widget;
  final String? fieldLabel;
  final double? width;
  final double? height;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final Function()? onEditingComplete;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? hintText;
  final int? maxLines;
  final bool? enabled;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onPressed;
  final ValueChanged<String>? onChanged;
  final bool? obscure;
  final Color? focusColor;
  final Color? styleColor;
  final TextStyle? hintTextStyle;
  final Color? textColor;
  final Color? borderColor;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final int? max;
  final onChange;
  final onSubmit;
  final String? Function(String?)? validaton;
  final bool? enable;
  const AuthTextField({
    this.fieldLabel,
    this.hintText,
    this.controller,
    super.key,
    this.inputType = TextInputType.text,
    this.suffixIcon,
    this.maxLines = 1,
    this.onEditingComplete,
    this.onPressed,
    this.style,
    this.readOnly = false,
    this.textInputAction,
    this.prefixIcon,
    this.inputFormatters,
    this.maxLength,
    this.focusNode,
    this.enabled,
    this.obscureText = false,
    this.onChanged,
    this.widget,
    this.width,
    this.height,
    this.obscure,
    this.focusColor,
    this.styleColor,
    this.hintTextStyle,
    this.textColor,
    this.borderColor,
    this.fillColor,
    this.keyboardType,
    this.max,
    this.onChange,
    this.onSubmit,
    this.validaton,
    this.enable,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height ?? 40,
          width: width,
          child: TextFormField(
            minLines: 1,
             
            enabled: enabled ?? true,
            obscureText: obscure ?? false,
            focusNode: focusNode,
            maxLength: maxLength,
            style:
                style ??
                TextStyle(
                  color: const Color(0xff8E4018),
                  fontFamily: 'GROBOLD',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
            onTap: onPressed,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            onChanged: onChange,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.next,
            readOnly: readOnly,
            onEditingComplete: onEditingComplete,
            inputFormatters: inputFormatters,
            validator: validaton,
            maxLines: maxLines ?? 2,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              errorStyle: const TextStyle(height: 0),
              contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
              // suffixIconConstraints: const BoxConstraints(
              //     minWidth: 10, minHeight: 45, maxHeight: 50,),
              // prefixIconConstraints: const BoxConstraints(
              //     minWidth: 40, minHeight: 40, maxHeight: 50, ),
              errorMaxLines: 1,
              filled: true,
              fillColor: fillColor ?? const Color(0XFFF9F9F9),
              hintText: hintText,
              hintStyle: hintTextStyle,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: borderColor ?? Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: (borderColor ?? Colors.transparent),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: (focusColor ?? Colors.transparent),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: appRed),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: appRed),
                borderRadius: BorderRadius.circular(6),
              ),

              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
