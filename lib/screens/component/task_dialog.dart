import 'package:adrevauth/screens/component/task_card.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/button.dart';
import 'package:adrevauth/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../adrevauth.dart';
import '../../models/user_task.dart';
import '../../services/auth_service.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {

  Future<List<UserTask>>? _tasksFuture;
  Map<String, dynamic>? _dashboardFuture;

  final adrevAuth = AdrevAuth.instance;
  final authService = AuthService.instance;


  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  void _handleTaskAction(UserTask task) {
    if (task.task.code.contains('watch') || task.task.code.contains('daily')) {
      adrevAuth.showRewardedAd(
        onReward: () async {
          String value = task.task.code.contains("login")
              ? "login"
              : "watch_ad";
          if (task.task.code.contains('watch')) {
            await adrevAuth
                .watchadlogging(); // This method does not exist on AdrevAuth
          }

          if (task.task.code.contains('daily')) {
            await adrevAuth.dailylogging();
          }
          _refreshTasks(); // Refresh the list after reward
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Reward granted!')));
          }
        },
      );
    } else {
      adrevAuth.startGamelogging();
      adrevAuth.startGame();
    }
  }

  Future<void> _refreshTasks() async {
    final dashboardData = await authService.dashboard();
    if (mounted) {
      setState(() {
        _dashboardFuture = dashboardData;
        _tasksFuture = authService.mytask();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(16  ),
      child: Container(
        height: 400,
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
                        image: AssetImage('packages/adrevauth/images/wooden_bg.png'),
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
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'images/task_header.png',
                    package: 'adrevauth',
                  ),
                ),
              ),
              Positioned(
                top: 82,
                right: 80,
                left: 80,
                child: FutureBuilder<List<UserTask>>(
                  future: _tasksFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0),
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return Center(
                        child: CustomText(
                                        text: 'No tasks available right now.',
                                        textColor: const Color(0xFF2D6A2D),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13  ,
                                      ),
                                    );
                    }
                    List<UserTask> tasks = snapshot.data!;
                    return
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tasks.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          final bool isCompleted = task.progressCount >= task.task.targetCount;
                          final double progress = isCompleted
                              ? 1.0
                              : (task.progressCount /
                              (task.task.targetCount == 0 ? 1 : task.task.targetCount));
                          if (task.task.code.contains('reach_highscore')) {
                            AdrevAuth.instance.highscore = task.task.targetCount;
                          }
                          return TasksCard(
                            children: [
                              CustomText(
                                text: task.task.title,
                                textColor: const Color(0xFF2D6A2D),
                                fontWeight: FontWeight.bold,
                                fontSize: 13  ,
                              ),
                              WorldProgressBar(progress: task.progressCount, total: task.task.targetCount),
                            ],
                          );
                        },
                      );
                  },
                ),
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     TasksCard(
                //       children: [
                //         CustomText(
                //           text: 'World Progress',
                //           textColor: const Color(0xFF2D6A2D),
                //           fontWeight: FontWeight.bold,
                //           fontSize: 13  ,
                //         ),
                //         WorldProgressBar(progress: 2, total: 10),
                //       ],
                //     ),
                //     Padding(
                //       padding: EdgeInsets.symmetric(vertical: 20  ),
                //       child: Image.asset(
                //         'images/Line.png',
                //       ),
                //     ),
                //     TasksCard(
                //       hasBox: false,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Image.asset(
                //               'images/lamp.png',
                //               width: 20  ,
                //               height: 20  ,
                //             ),
                //             7.0  .spacingW,
                //             CustomText(
                //               text: 'Lamp',
                //               textColor: const Color(0xFF2D6A2D),
                //               fontWeight: FontWeight.bold,
                //               fontSize: 13  ,
                //             ),
                //             20.0  .spacingW,
                //             Image.asset(
                //               'images/do_it_button.png',
                //               width: 70  ,
                //               height: 35  ,
                //             )
                //           ],
                //         ),
                //       ],
                //     ),
                //     24.0  .spacingH,
                //     TasksCard(
                //       hasBox: false,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Image.asset(
                //               'images/well.png',
                //               width: 20  ,
                //               height: 20  ,
                //             ),
                //             7.0  .spacingW,
                //             CustomText(
                //               text: 'Well',
                //               textColor: const Color(0xFF2D6A2D),
                //               fontWeight: FontWeight.bold,
                //               fontSize: 13  ,
                //             ),
                //             27.0  .spacingW,
                //             Image.asset(
                //               'images/do_it_button.png',
                //               width: 70  ,
                //               height: 35  ,
                //             )
                //           ],
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
