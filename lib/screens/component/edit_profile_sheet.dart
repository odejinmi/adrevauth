import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/gradient_text.dart';
import 'package:adrevauth/widgets/gradient_text_field.dart';
import 'package:flutter/material.dart';

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> flags = [
      'images/can.png',
      'images/germany.png',
      'images/can.png',
      'images/germany.png',
      'images/can.png',
      'images/germany.png',
      'images/can.png',
      'images/germany.png',
      'images/can.png',
      'images/germany.png',
      'images/can.png',
      'images/germany.png',
    ];
    final TextEditingController controller =  TextEditingController();
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        //  width: 280.w,
                        child: Image.asset(
                          'images/wooden.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 11,
                        left: 10,
                        top: 20,
                        bottom: 20,
                        child: Image.asset(
                          'images/blank_sheet.png',
                          width: 245,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    right: -1,
                    left: -1,
                    child: InkWell(
                      hoverColor: transparent,
                      focusColor: transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('images/edit_header.png'),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 5,
                left: 40,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  decoration: const BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 50),

                       GradientField(label: 'Change name',controller: controller,),
                      15.0.spacingH,
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xff8E4018), Color(0xffC58509)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds),
                        child: Text(
                          'Change profile picture',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'GROBOLD',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      7.0.spacingH,
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: const LinearGradient(
                            colors: [Color(0xffFFC62D), Color(0xffFF9200)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * .58,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: whiteColor,
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 7,
                                  childAspectRatio: 48 / 38,
                                ),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Image.asset(flags[index]);
                            },
                          ),
                        ),
                      ),
                      10.spacingH,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .2,
                        ),
                        child: InkWell(onTap: () {}, child: _buildButton()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildButton() {
  return Container(
    height: 32,
    width: 72,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: const LinearGradient(
        colors: [Color(0xff65BA09), Color(0xff8CE30B)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: const Center(
      child: GradientText(
        label: 'Accept',
        gradientColor: [Color(0xff4F8100), Color(0xff304F00)],
      ),
    ),
  );
}
