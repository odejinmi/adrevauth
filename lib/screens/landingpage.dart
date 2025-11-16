import 'package:adrevauth/screens/settings/component/image_filled_text.dart';
import 'package:flutter/material.dart';

import '../adrevauth.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../utils/extension/widget_extensions.dart';
import 'login_screen.dart';

class Landingpage extends StatelessWidget {
  const Landingpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adrevAuth = AdrevAuth.instance;
    return Stack(
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
                onTap: () {
                  adrevAuth.startGame();
                },
                child: Image.asset(
                  'packages/adrevauth/images/play_button.png',
                  height: 59,
                  width: 145,
                ),
              ),
              40.0.spacingH,
              StreamBuilder<bool>(
                stream: adrevAuth.onAuthStateChanged,
                builder: (context, snapshot) {
                  // While waiting for the initial auth state, show a loading indicator
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final isAuthenticated = snapshot.data ?? false;

                  // If the stream says the user is authenticated...
                  if (isAuthenticated) {
                    // ...show the app's main home screen.
                    return InkWell(
                      onTap: () {
                        final _authService = AuthService.instance;
                        _authService.logout();
                      },
                      child: Image.asset(
                        'packages/adrevauth/images/logout_button.png',
                        height: 59,
                        width: 145,
                      ),
                    );
                  } else {
                    // ...otherwise, show the SDK's login screen.
                    return InkWell(
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
                    );
                  }
                  // if (snapshot.data == true) {
                  //   // If logged in, go to the SDK's rewards screen first
                  //   return adrevAuth.rewardsScreen;
                  //   // If logged in, go directly to the app's home screen.
                  //   // The SDK will have already shown the rewards screen internally.
                  //   return HomePage(adrevAuth: adrevAuth,);
                  // }
                  //  else {
                  // return adrevAuth.initialScreen;
                  // }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
