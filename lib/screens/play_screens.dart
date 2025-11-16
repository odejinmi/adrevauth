import 'package:adrevauth/screens/component/coin_button.dart';
import 'package:adrevauth/screens/component/leader_board_dialog.dart';
import 'package:adrevauth/screens/component/settings_dialog.dart';
import 'package:adrevauth/screens/component/task_dialog.dart';
import 'package:adrevauth/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../adrevauth.dart';

class PlayScreens extends StatefulWidget {
  const PlayScreens({super.key});

  @override
  State<PlayScreens> createState() => _PlayScreensState();
}

class _PlayScreensState extends State<PlayScreens> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'packages/adrevauth/images/Isle.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset('packages/adrevauth/images/header.png'),
                  SafeArea(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'packages/adrevauth/images/Flag.png',
                            height: 47,
                            width: 71,
                          ),
                          SizedBox(
                            height: 38,
                            child: CoinButton(
                              onPressed: () {},
                            ),
                          ),
                          Image.asset(
                            'packages/adrevauth/images/lock.png',
                            height: 47,
                            width: 71,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        AdrevAuth.instance.startGame();
                      },
                      child: Image.asset(
                        'packages/adrevauth/images/level1.png',
                        height: 59,
                        width: 150,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => const TaskDialog(),
                        );
                      },
                      child: Image.asset(
                        'packages/adrevauth/images/Zone.png',
                        height: 59,
                        width: 150,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Image.asset('packages/adrevauth/images/header.png'),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 21),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => const SettingsDialog(),
                                  );
                                },
                                child: Image.asset('packages/adrevauth/images/game_setting.png',
                                    height: 59)),
                            InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => const LeaderBoardDialog(),
                                  );
                                },
                                child: Image.asset('packages/adrevauth/images/menu.png',
                                    height: 59)),
                            InkWell(
                                onTap: () {
                                  
                                },
                                child: Image.asset('packages/adrevauth/images/dash.png',
                                    height: 59)),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}