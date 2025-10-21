import 'package:flutter/material.dart';
import 'package:adrevauth/adrevauth.dart'; // The app imports your SDK

import 'home_page.dart'; // The app's own home screen

Future<void> main() async {
  // The app initializes your SDK before running
  final adrevAuth = await AdrevAuth.initialize(
      bannerAdUnitId: '',
      interstitialAdUnitId: '',
      rewardedAdUnitId: '',
      onStartGame: () {
        // The app defines what happens when the user starts the game
      },
  );
  runApp(MyApp(adrevAuth: adrevAuth));
}

class MyApp extends StatelessWidget {
  final AdrevAuth adrevAuth;

  const MyApp({super.key, required this.adrevAuth});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Awesome App',
      // The home is an AuthGate widget that listens to your SDK
      home: AuthGate(adrevAuth: adrevAuth),
    );
  }
}

// This is the gatekeeper widget
class AuthGate extends StatelessWidget {
  final AdrevAuth adrevAuth;

  const AuthGate({super.key, required this.adrevAuth});

  @override
  Widget build(BuildContext context) {
    // This is where the onStartGame function is given its navigation logic
    adrevAuth.startGame = () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage(adrevAuth: adrevAuth)),
      );
    };
    // It uses a StreamBuilder to listen to your SDK's auth state stream
    return StreamBuilder<bool>(
      stream: adrevAuth.onAuthStateChanged,
      builder: (context, snapshot) {
        // // While waiting for the initial auth state, show a loading indicator
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Scaffold(
        //     body: Center(child: CircularProgressIndicator()),
        //   );
        // }
        //
        // final isAuthenticated = snapshot.data ?? false;
        //
        // // If the stream says the user is authenticated...
        // if (isAuthenticated) {
        //   // ...show the app's main home screen.
        //   return HomePage(adrevAuth: adrevAuth,);
        // } else {
        //   // ...otherwise, show the SDK's login screen.
        //   return adrevAuth.initialScreen;
        // }
        if (snapshot.data == true) {
          // If logged in, go to the SDK's rewards screen first
          return adrevAuth.rewardsScreen;
          // If logged in, go directly to the app's home screen.
          // The SDK will have already shown the rewards screen internally.
          return HomePage(adrevAuth: adrevAuth,);
        } else {
          return adrevAuth.initialScreen;
        }
      },
    );
  }
}