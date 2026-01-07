import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:adrevauth/adrevauth.dart'; // The app imports your SDK
import 'package:flutter/services.dart';

import 'home_page.dart'; // The app's own home screen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ByteData data = await rootBundle.load('assets/images/lamp.png');
  final String base64Image = base64Encode(data.buffer.asUint8List());
  // The app initializes your SDK before running
  final adrevAuth = await AdrevAuth.initialize(
    bannerAdUnitId: '',
    interstitialAdUnitId: '',
    rewardedAdUnitId: '',
    onStartGame: () {
      // The app defines what happens when the user starts the game
    },
    imagelogo: base64Image,
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
    return adrevAuth.initialScreen;
    // return Image.asset('assets/images/lamp.png');
  }
}
