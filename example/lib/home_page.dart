import 'dart:convert';

import 'package:adrevauth/adrevauth.dart';
import 'package:adrevauth/screens/component/image_filled_text.dart';
import 'package:adrevauth/screens/login_screen.dart';
import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final AdrevAuth adrevAuth;
  const HomePage({super.key, required this.adrevAuth});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final _notificationService = NotificationService();
  int _unreadCount = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _fetchUnreadCount();
  }

  // Future<void> _fetchUnreadCount() async {
  //   if (_isLoading) return;
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     final response = await _notificationService.getNotificationCount();
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (mounted) {
  //         setState(() {
  //           _unreadCount = data['data']['total'];
  //         });
  //       }
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final List<(String, String, IconData)> games = [
      ('Chess', '/chess', Icons.sports_esports),
      ('Sudoku', '/sudoku', Icons.grid_4x4),
      ('Word Scramble', '/word_puzzles', Icons.text_fields),
      ('2048', '/2048', Icons.view_module),
      ('Word Search', '/word_search', Icons.search),
      ('Daily Rewards', '/rewards', Icons.card_giftcard),
      // ('Ad Settings', '/ad_settings', Icons.settings),
    ];

    // final themeCtrl = ThemeController.of(context);
    // final currentMode = themeCtrl.mode;

    return
    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text('AdRev Games'),
    //     actions: [
    // IconButton(
    //   icon: _isLoading
    //       ? const SizedBox(
    //           width: 24,
    //           height: 24,
    //           child: CircularProgressIndicator(strokeWidth: 2),
    //         )
    //       : Badge(
    //           label: Text('$_unreadCount'),
    //           isLabelVisible: _unreadCount > 0,
    //           child: const Icon(Icons.notifications),
    //         ),
    //   onPressed: _isLoading
    //       ? null
    //       : () async {
    //           await Navigator.pushNamed(context, '/notifications');
    //           _fetchUnreadCount();
    //         },
    // ),
    // PopupMenuButton<String>(
    //   tooltip: 'Theme Mode',
    //   icon: const Icon(Icons.brightness_6),
    //   initialValue: _modeToString(currentMode),
    //   onSelected: (value) {
    //     switch (value) {
    //       case 'light':
    //         themeCtrl.setMode(ThemeMode.light);
    //         break;
    //       case 'dark':
    //         themeCtrl.setMode(ThemeMode.dark);
    //         break;
    //       case 'system':
    //       default:
    //         themeCtrl.setMode(ThemeMode.system);
    //     }
    //   },
    //   itemBuilder: (context) => const [
    //     PopupMenuItem(value: 'system', child: Text('System')),
    //     PopupMenuItem(value: 'light', child: Text('Light')),
    //     PopupMenuItem(value: 'dark', child: Text('Dark')),
    //   ],
    // ),
    //   ],
    // ),
    //   body: ListView.separated(
    //     padding: const EdgeInsets.all(16),
    //     itemCount: games.length,
    //     separatorBuilder: (_, __) => const SizedBox(height: 12),
    //     itemBuilder: (context, index) {
    //       final (title, route, icon) = games[index];
    //       return Card(
    //         child: ListTile(
    //           leading: Icon(icon),
    //           title: Text(title),
    //           trailing: const Icon(Icons.chevron_right),
    //           onTap: () => route == '/rewards'?Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (context) => widget.adrevAuth.rewardsScreen,
    //             ),
    //           ): Navigator.pushNamed(context, route),
    //         ),
    //       );
    //     },
    //   ),
    // );
    Stack(
      children: [
        Positioned.fill(
          child: Transform.scale(
            scale: 1.05,
            child: Image.asset(
              'packages/adrevauth/images/Bg.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 73,
          child: Image.asset(
            'packages/adrevauth/images/treasure_hunt.png',
            height: 204,
            width: 204,
          ),
        ),
        Scaffold(
          backgroundColor: transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              192.0.spacingH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 183,
                          child: Row(
                            children: [
                              Image.asset(
                                'packages/adrevauth/images/leaf.png',
                                height: 100,
                                width: 144,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 120),
                                child: Transform.rotate(
                                  angle: 3.14159,
                                  child: Image.asset(
                                    'packages/adrevauth/images/leaf.png',
                                    height: 110,
                                    width: 155,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 75,
                          left: 30,
                          // right: 36.w,
                          child: ImageFilledText(
                            text: 'EMMY',
                            imagePath: 'packages/adrevauth/images/style.png',
                            fontSize: 75,
                            strokeColor: const Color(0xffBC25DB),
                            strokeWidth: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              36.0.spacingH,
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'packages/adrevauth/images/play_button.png',
                  height: 59,
                  width: 145,
                ),
              ),
              40.0.spacingH,
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Image.asset(
                  'packages/adrevauth/images/login_button.png',
                  height: 59,
                  width: 145,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _modeToString(ThemeMode m) {
    switch (m) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
      default:
        return 'system';
    }
  }
}
