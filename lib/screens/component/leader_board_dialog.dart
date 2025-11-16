import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class LeaderBoardDialog extends StatelessWidget {
  const LeaderBoardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(16),
      child: Center(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .46,
                  width: 270,
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/wooden_bg.png', package: 'adrevauth'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [],
                      ),
                      40.0.spacingH,
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                hoverColor: transparent,
                focusColor: transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('images/leaderboard.png', package: 'adrevauth'),
              ),
            ),
            Positioned(
              top: 70,
              right: 80,
              left: 80,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .26,
                height: MediaQuery.of(context).size.height * .32,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        GradientText(
                          label: '${index + 1}',
                          gradientColor: [Color(0XFF329404), Color(0XFFC58509)],
                        ),
                        16.0.spacingW,
                        GradientText(
                          label: 'Samso',
                          gradientColor: [Color(0XFF8E4018), Color(0XFFC58509)],
                        ),
                        Spacer(),
                        GradientText(
                          label: '294',
                          gradientColor: [Color(0XFF8E4018), Color(0XFFC58509)],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
