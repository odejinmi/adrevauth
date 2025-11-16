import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class WorldProgressBar extends StatelessWidget {
  const WorldProgressBar({required this.progress, required this.total});

  final int progress;
  final int total;

  @override
  Widget build(BuildContext context) {
    final double progressRatio = progress / (total== 0 ?1:total);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 8  ,
          width: 150  ,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
              height: 8  ,
              width: 80   * progressRatio,
              decoration: BoxDecoration(
                color: const Color(0xFFEB8B22),
                borderRadius: BorderRadius.circular(10),
              ),
                      ),
                      Spacer()
            ],
          ),
        ),
        GradientText(label: '$progress/$total', gradientColor: [
          Color(0XFF4F8100),
           Color(0XFF304F00)
        ],fontSize: 10  ,)
        
      ],
    );
  }
}
