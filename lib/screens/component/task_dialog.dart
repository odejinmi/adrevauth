import 'package:adrevauth/screens/component/task_card.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/button.dart';
import 'package:adrevauth/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TaskDialog extends StatelessWidget {
  const TaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(16  ),
      child: Center(
        // ✅ ensures the dialog content is centered
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .46,
                  width: 270  ,
                  padding:
                      EdgeInsets.symmetric(vertical: 40  , horizontal: 20  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/wooden_bg.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 50  ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [],
                      ),
                      40.0  .spacingH,
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/task_header.png',
              ),
            ),
            Positioned(
              top: 82,
              right: 80,
              left: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TasksCard(
                    children: [
                      CustomText(
                        text: 'World Progress',
                        textColor: const Color(0xFF2D6A2D),
                        fontWeight: FontWeight.bold,
                        fontSize: 13  ,
                      ),
                      WorldProgressBar(progress: 2, total: 10),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20  ),
                    child: Image.asset(
                      'images/Line.png',
                    ),
                  ),
                  TasksCard(
                    hasBox: false,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'images/lamp.png',
                            width: 20  ,
                            height: 20  ,
                          ),
                          7.0  .spacingW,
                          CustomText(
                            text: 'Lamp',
                            textColor: const Color(0xFF2D6A2D),
                            fontWeight: FontWeight.bold,
                            fontSize: 13  ,
                          ),
                          20.0  .spacingW,
                          Image.asset(
                            'images/do_it_button.png',
                            width: 70  ,
                            height: 35  ,
                          )
                        ],
                      ),
                    ],
                  ),
                  24.0  .spacingH,
                  TasksCard(
                    hasBox: false,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'images/well.png',
                            width: 20  ,
                            height: 20  ,
                          ),
                          7.0  .spacingW,
                          CustomText(
                            text: 'Well',
                            textColor: const Color(0xFF2D6A2D),
                            fontWeight: FontWeight.bold,
                            fontSize: 13  ,
                          ),
                          27.0  .spacingW,
                          Image.asset(
                            'images/do_it_button.png',
                            width: 70  ,
                            height: 35  ,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
