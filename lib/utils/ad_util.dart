import '../ads/ad_service.dart';
import '../services/settings_service.dart';

// Future<T> showInterstitialOnPop<T>(T result) async {
//   final settings = SettingsService();
//   if (settings.showAdsOnClose) {
//     await AdService.instance.showInterstitialIfReady();
//   }
//   return result;
// }
//
// Future<T> showRewardedOnPageOpen<T>(T result) async {
//   final settings = SettingsService();
//   if (settings.showAdsOnOpen) {
//     await AdService.instance.showRewarded(onReward: () {});
//   }
//   return result;
// }

class AdUtils {
  static final AdUtils _instance = AdUtils._internal();
  factory AdUtils() => _instance;
  AdUtils._internal();

  final SettingsService _settings = SettingsService();

  bool get showAdsOnOpen => _settings.showAdsOnOpen;
  bool get showAdsOnClose => _settings.showAdsOnClose;

  Future<void> setShowAdsOnOpen(bool value) => _settings.setShowAdsOnOpen(value);
  Future<void> setShowAdsOnClose(bool value) => _settings.setShowAdsOnClose(value);
}