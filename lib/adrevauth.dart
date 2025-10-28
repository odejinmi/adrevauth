import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/rewards_screen.dart';
import 'ads/ad_service.dart';



/// The main entry point for the AdrevAuth SDK.
class AdrevAuth {
  final AuthService _authService;
  final AdService _adService;
  /// Callback function to start the main game
  /// This can be reassigned by the app to customize the game start behavior
  late VoidCallback startGame;

  // Private constructor
  AdrevAuth._(
    this._authService, 
    this._adService,
    VoidCallback onStartGame,
  ) {
    // Initialize startGame with the provided callback
    startGame = onStartGame;
  }

  // Singleton instance
  static AdrevAuth? _instance;

  static AdrevAuth get instance {
    if (_instance == null) {
      throw Exception('AdrevAuth has not been initialized. Call AdrevAuth.initialize() first.');
    }
    return _instance!;
  }

  /// Initializes the AdrevAuth SDK.
  ///
  /// This must be called once before the app runs. The developer must provide
  /// their ad unit IDs.
  static Future<AdrevAuth> initialize({
    required String bannerAdUnitId,
    required String interstitialAdUnitId,
    required String rewardedAdUnitId,
    required VoidCallback onStartGame,
  }) async {
    if (_instance != null) {
      return _instance!;
    }

    final adService = AdService(
      bannerAdUnitId: bannerAdUnitId,
      interstitialAdUnitId: interstitialAdUnitId,
      rewardedAdUnitId: rewardedAdUnitId,
    );
    adService.init();

    _instance = AdrevAuth._(AuthService.instance, adService,  onStartGame);
    return _instance!;
  }


  // --- UI Screens --- //

  Widget get initialScreen => const LoginScreen();
  Widget get rewardsScreen => const RewardsScreen();

  int _highscore = 0;
  int get highscore => _highscore;
  set highscore(int value) => _highscore = value;

  VoidCallback? exitGame;
  // --- Authentication --- //

  Stream<bool> get onAuthStateChanged => _authService.onAuthStateChanged;

  /// Signs the user in and, on success, enrolls them for the app.
  Future<bool> login({required String email, required String password}) async {
    final success = await _authService.login(email, password);
    if (success) {
      // After a successful login, enroll the user for this app.
      _authService.enrolluser().then((enrollSuccess) {
        if (!enrollSuccess) {
          // Optional: Log this failure for debugging purposes.
          print('AdrevAuth SDK: Failed to enroll user for app ');
        }
      });
    }
    return success;
  }

  /// Triggers the callback to start the main game, as defined by the consuming app.
  /// This is now a function variable that can be reassigned

  Future<bool> Logging(String code,String highscore) async {
      final success = await _authService.logging(code,  highscore);
      return success;
    }

  Future<bool> wingamelogging() async {
      final success = await _authService.logging("win_game", "0");
      return success;
    }

  Future<bool> watchadlogging() async {
    final success = await _authService.logging("watch_ad", "0");
    return success;
  }


  Future<bool> highscorelogging(String newscore) async {
    final success = await _authService.logging("highscore", newscore);
    return success;
  }

   Future<bool> play_daylogging() async {
    final success = await _authService.logging("play_day", "0");
    return success;
  }

  Future<void> signOut() => _authService.logout();

  // --- Ads --- //

  Future<bool> showRewardedAd({required void Function() onReward}) {
    return _adService.showRewarded(onReward: onReward);
  }

  Future<bool> showInterstitialAd() {
    return _adService.showInterstitialIfReady();
  }

  Widget createBannerAd({AdSize size = AdSize.banner}) {
    return SizedBox(
      width: size.width.toDouble(),
      height: size.height.toDouble(),
      child: AdWidget(ad: _adService.createBanner(size: size)),
    );
  }

  void dispose() {
    _authService.dispose();
  }
}
