import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  static const String _showAdsOnOpenKey = 'show_ads_on_open';
  static const String _showAdsOnCloseKey = 'show_ads_on_close';
  static const bool _defaultShowAds = true;

  late SharedPreferences _prefs;
  bool _showAdsOnOpen = _defaultShowAds;
  bool _showAdsOnClose = _defaultShowAds;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _showAdsOnOpen = _prefs.getBool(_showAdsOnOpenKey) ?? _defaultShowAds;
    _showAdsOnClose = _prefs.getBool(_showAdsOnCloseKey) ?? _defaultShowAds;
  }

  bool get showAdsOnOpen => _showAdsOnOpen;
  bool get showAdsOnClose => _showAdsOnClose;

  Future<void> setShowAdsOnOpen(bool value) async {
    _showAdsOnOpen = value;
    await _prefs.setBool(_showAdsOnOpenKey, value);
  }

  Future<void> setShowAdsOnClose(bool value) async {
    _showAdsOnClose = value;
    await _prefs.setBool(_showAdsOnCloseKey, value);
  }
}
