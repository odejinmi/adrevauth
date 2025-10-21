import 'package:flutter/material.dart';

import '../utils/ad_utils.dart';

class AdSettingsScreen extends StatefulWidget {
  const AdSettingsScreen({super.key});

  @override
  State<AdSettingsScreen> createState() => _AdSettingsScreenState();
}

class _AdSettingsScreenState extends State<AdSettingsScreen> {
  late bool _showAdsOnOpen;
  late bool _showAdsOnClose;
  final _adUtils = AdUtils();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _showAdsOnOpen = _adUtils.showAdsOnOpen;
    _showAdsOnClose = _adUtils.showAdsOnClose;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ad Preferences',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Show ads when opening a game'),
                    value: _showAdsOnOpen,
                    onChanged: (value) async {
                      await _adUtils.setShowAdsOnOpen(value);
                      setState(() {
                        _showAdsOnOpen = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Show ads when closing a game'),
                    value: _showAdsOnClose,
                    onChanged: (value) async {
                      await _adUtils.setShowAdsOnClose(value);
                      setState(() {
                        _showAdsOnClose = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Note: Disabling ads may affect your ability to earn rewards.',
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
