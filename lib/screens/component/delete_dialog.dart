import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

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
                  height: 240,
                  width: 270,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/woodenBgHalf.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientText(
                            fontSize: 13,
                            label:
                                'Are you sure you want to\ndelete your account permanently ',
                            gradientColor: [
                              Color(0XFF8E4018),
                              Color(0XFFC58509),
                            ],
                          ),
                        ],
                      ),
                      30.0.spacingH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/no.png', height: 70, width: 72),
                          32.spacingW,
                          Image.asset('images/yes.png', height: 70, width: 72),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('images/delete.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
