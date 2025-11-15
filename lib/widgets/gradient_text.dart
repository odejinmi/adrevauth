import 'package:flutter/material.dart';
class GradientText extends StatelessWidget {
  const GradientText(
      {super.key, required this.label, required this.gradientColor, this.fontSize=14});
  final String label;
  final List<Color> gradientColor;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: gradientColor,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bounds),
      child: Text(
        textAlign: TextAlign.center,
        label,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'GROBOLD',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
