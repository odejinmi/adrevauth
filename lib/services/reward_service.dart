import 'package:shared_preferences/shared_preferences.dart';

import '../adrevauth.dart';

class RewardService {
  static final RewardService _instance = RewardService._internal();
  factory RewardService() => _instance;
  RewardService._internal();

  static const String _lastClaimedKey = 'last_claimed_reward';

  Future<bool> canClaimDailyReward() async {
    final prefs = await SharedPreferences.getInstance();
    final lastClaimed = prefs.getString(_lastClaimedKey);

    if (lastClaimed == null) return true;

    final lastClaimedDate = DateTime.parse(lastClaimed);
    final now = DateTime.now();

    // Check if 24 hours have passed since the last claim
    return now.difference(lastClaimedDate).inHours >= 24;
  }

  Future<bool> claimDailyReward() async {
    final canClaim = await canClaimDailyReward();
    if (!canClaim) return false;

    // Correctly use the public AdrevAuth instance to show the ad
    final claimed = await AdrevAuth.instance.showRewardedAd(
      onReward: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          _lastClaimedKey,
          DateTime.now().toIso8601String(),
        );
        // TODO: Add your reward logic here (e.g., give user coins, lives, etc.)
      },
    );

    return claimed;
  }

  Future<DateTime?> getLastClaimedDate() async {
    final prefs = await SharedPreferences.getInstance();
    final lastClaimed = prefs.getString(_lastClaimedKey);
    return lastClaimed != null ? DateTime.parse(lastClaimed) : null;
  }

  Future<Duration> timeUntilNextReward() async {
    final lastClaimed = await getLastClaimedDate();
    if (lastClaimed == null) return Duration.zero;

    final nextAvailable = lastClaimed.add(const Duration(hours: 24));
    final now = DateTime.now();

    if (now.isAfter(nextAvailable)) return Duration.zero;
    return nextAvailable.difference(now);
  }
}
