import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/auth_text_field.dart';
import 'package:adrevauth/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class GradientField extends StatelessWidget {
  const GradientField({
    this.label = '',
    this.hint = '',
    this.showObscure = false,
    this.obscure,
    this.ontap,
    this.validator,
   required this.controller,
    super.key,
  });
  final String label;
  final String hint;
  final bool? obscure;
  final bool showObscure;
  final VoidCallback? ontap;
  final TextEditingController controller;
  final validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((label).isNotEmpty) ...[
          Row(
            children: [
              GradientText(
                gradientColor: const [Color(0xff8E4018), Color(0xffC58509)],
                label: label,
              ),
            ],
          ),
          7.0.spacingH,
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Color(0xffFFC62D), Color(0xffFF9200)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: MediaQuery.of(context).size.width * .6,

          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: AuthTextField(
              fieldLabel: label,
              obscure: obscure,
              validaton: validator,
              suffixIcon: showObscure
                  ? (IconButton(
                      icon: Icon(
                        (obscure ?? false)
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 16,
                        color: Colors.black,
                      ),
                      onPressed: ontap,
                    ))
                  : SizedBox.shrink(),
              hintText: hint,
              hintTextStyle: TextStyle(
                color: const Color(0xff8E4018),
                fontFamily: 'GROBOLD',
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
              controller: controller,
              style: TextStyle(
                color: const Color(0xff8E4018),
                fontFamily: 'GROBOLD',
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              width: MediaQuery.of(context).size.width * .6,
            ),
          ),
        ),
      ],
    );
  }
}
