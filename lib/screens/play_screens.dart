import 'package:adrevauth/models/user_task.dart';
import 'package:adrevauth/screens/component/coin_button.dart';
import 'package:adrevauth/screens/component/leader_board_dialog.dart';
import 'package:adrevauth/screens/component/settings_dialog.dart';
import 'package:adrevauth/screens/component/task_dialog.dart';
import 'package:adrevauth/screens/login_screen.dart';
import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/button.dart';
import 'package:adrevauth/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

import '../adrevauth.dart';

class PlayScreens extends StatefulWidget {
  const PlayScreens({super.key});

  @override
  State<PlayScreens> createState() => _PlayScreensState();
}

class _PlayScreensState extends State<PlayScreens> {
  Future<List<UserTask>>? _tasksFuture;
  int? zone;
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
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
                            child: CoinButton(onPressed: () {}),
                          ),
                          Image.asset(
                            'packages/adrevauth/images/lock.png',
                            height: 47,
                            width: 71,
                          ),
                        ],
                      ),
                    ),
                  ),
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
                      child: Stack(
                        children: [
                          Image.asset(
                            'packages/adrevauth/images/zone_button.png',
                            height: 59,
                            width: 150,
                          ),
                          Positioned(
                            top: 0,
                            left: 10,
                            bottom: 0,
                            child: FutureBuilder<List<UserTask>>(
                              future: _tasksFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting &&
                                    !snapshot.hasData) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24.0),
                                        topRight: Radius.circular(24.0),
                                      ),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                if (snapshot.hasError ||
                                    !snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return SizedBox(
                                    width: 104,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          10.0.spacingH,
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10.0,
                                            ),
                                            child: GradientText(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              label: 'Zone ${zone ?? 1}',
                                              gradientColor: [
                                                Color(0xff4F8100),
                                                Color(0xff304F00),
                                              ],
                                            ),
                                          ),
                                          WorldProgressBar(
                                            progress: 0,
                                            total: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                List<UserTask> tasks = snapshot.data!;
                                return ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final task = tasks[index];
                                    final bool isCompleted =
                                        task.progressCount >=
                                        task.task.targetCount;
                                    final double progress = isCompleted
                                        ? 1.0
                                        : (task.progressCount /
                                              (task.task.targetCount == 0
                                                  ? 1
                                                  : task.task.targetCount));
                                    if (task.task.code.contains(
                                      'reach_highscore',
                                    )) {
                                      AdrevAuth.instance.highscore =
                                          task.task.targetCount;
                                    }
                                    setState(() {
                                      zone = task.progressCount;
                                    });
                                    return WorldProgressBar(
                                      progress: task.progressCount,
                                      total: task.task.targetCount,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Image.asset(
                              'images/treasureBox.png',
                              package: 'adrevauth',
                              width: 42,
                              height: 42,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: whiteColor,
                                border: Border.all(color: appRed),
                              ),
                              child: GradientText(
                                label: '${zone ?? 1}',
                                gradientColor: [
                                  Color(0XFF954B25),
                                  Color(0xffE49B0B)
                                ],
                              ),
                            ),
                          ),
                        ],
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
                        horizontal: 20,
                        vertical: 21,
                      ),
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
                            child: Image.asset(
                              'packages/adrevauth/images/game_setting.png',
                              height: 59,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => const LeaderBoardDialog(),
                              );
                            },
                            child: Image.asset(
                              'packages/adrevauth/images/menu.png',
                              height: 59,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'packages/adrevauth/images/dash.png',
                              height: 59,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
