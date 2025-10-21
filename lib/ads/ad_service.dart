import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Manages loading and showing ads. This class should not be used directly
/// by the consuming app. Use [AdrevAuth] to interact with ads.
class AdService {
  final String bannerAdUnitId;
  final String interstitialAdUnitId;
  final String rewardedAdUnitId;

  /// Creates an instance of [AdService] with the given ad unit IDs.
  AdService({
    required this.bannerAdUnitId,
    required this.interstitialAdUnitId,
    required this.rewardedAdUnitId,
  });

  bool get isSupported => !kIsWeb; // Only Android/iOS in this project

  Future<void> init() async {
    if (!isSupported) return;
    if (Platform.isAndroid || Platform.isIOS) {
      await MobileAds.instance.initialize();
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: const <String>[]),
      );
      _preloadInterstitial();
      _preloadRewarded();
    }
  }

  // Banner
  BannerAd createBanner({AdSize size = AdSize.banner}) {
    final ad = BannerAd(
      adUnitId: bannerAdUnitId, // Use the provided ID
      size: size,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    ad.load();
    return ad;
  }

  // Interstitial
  InterstitialAd? _interstitial;
  void _preloadInterstitial() {
    if (!isSupported) return;
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId, // Use the provided ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitial = ad,
        onAdFailedToLoad: (error) => _interstitial = null,
      ),
    );
  }

  Future<bool> showInterstitialIfReady() async {
    if (!isSupported) return false;
    final ad = _interstitial;
    if (ad == null) {
      _preloadInterstitial();
      return false;
    }
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitial = null;
        _preloadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitial = null;
        _preloadInterstitial();
      },
    );
    await ad.show();
    return true;
  }

  // Rewarded
  RewardedAd? _rewarded;
  void _preloadRewarded() {
    if (!isSupported) return;
    RewardedAd.load(
      adUnitId: rewardedAdUnitId, // Use the provided ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewarded = ad,
        onAdFailedToLoad: (error) => _rewarded = null,
      ),
    );
  }

  Future<bool> showRewarded({required void Function() onReward}) async {
    if (!isSupported) return false;
    final ad = _rewarded;
    if (ad == null) {
      _preloadRewarded();
      return false;
    }
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewarded = null;
        _preloadRewarded();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _rewarded = null;
        _preloadRewarded();
      },
    );
    await ad.show(
      onUserEarnedReward: (ad, reward) {
        onReward();
      },
    );
    return true;
  }
}
