import 'package:adrevauth/screens/component/delete_dialog.dart';
import 'package:adrevauth/screens/component/edit_profile_sheet.dart';
import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:flutter/material.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(16 ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 40  , horizontal: 20 ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/dialog.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 50  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSettingItem(
                          icon: 'images/sound.png',
                          label: 'Sound',
                        ),
                        _buildSettingItem(
                          icon: 'images/music.png',
                          label: 'Music',
                        ),
                      ],
                    ),
                    40.0.spacingH,
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (_) => const EditProfileDialog(),
                              );
                            },
                            child: _buildSettingItem(
                              icon: 'images/editprofile.png',
                              label: 'Profile',
                            ),
                          ),
                                                    InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (_) => const DeleteDialog(),
                              );
                            },
                            child: _buildSettingItem(
                              icon: 'images/editprofile.png',
                              label: 'Delete\naccount',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                hoverColor: transparent,
                focusColor: transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20  ),
                  height: 50  ,
                  width: MediaQuery.of(context).size.width * .8,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({required String icon, required String label}) {
    return SizedBox(
      height: 115  ,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 60  ,
            width: 60 ,
          ),
          SizedBox(height: 8  ),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xff8E4018), Color(0xffC58509)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'GROBOLD',
                fontSize: 15  ,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
