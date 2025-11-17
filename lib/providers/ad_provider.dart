import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

/// Provider for managing AdMob ads
class AdProvider with ChangeNotifier {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  bool _isInterstitialAdReady = false;
  bool _isRewardedAdReady = false;
  int _videoGenerationCount = 0;

  bool get isInterstitialAdReady => _isInterstitialAdReady;
  bool get isRewardedAdReady => _isRewardedAdReady;
  int get videoGenerationCount => _videoGenerationCount;

  AdProvider() {
    _loadVideoGenerationCount();
    _loadInterstitialAd();
    _loadRewardedAd();
  }

  /// Load video generation count from storage
  Future<void> _loadVideoGenerationCount() async {
    final prefs = await SharedPreferences.getInstance();
    _videoGenerationCount = prefs.getInt(AppConstants.keyVideoGenerationCount) ?? 0;
    notifyListeners();
  }

  /// Save video generation count to storage
  Future<void> _saveVideoGenerationCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.keyVideoGenerationCount, _videoGenerationCount);
  }

  /// Increment video generation count
  Future<void> incrementVideoGenerationCount() async {
    _videoGenerationCount++;
    await _saveVideoGenerationCount();
    notifyListeners();

    // Show interstitial ad every 3 video generations
    if (_videoGenerationCount % AppConstants.interstitialAdInterval == 0) {
      showInterstitialAd();
    }
  }

  /// Load interstitial ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AppConstants.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('InterstitialAd loaded successfully');
          _interstitialAd = ad;
          _isInterstitialAdReady = true;

          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('InterstitialAd showed');
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('InterstitialAd dismissed');
              ad.dispose();
              _isInterstitialAdReady = false;
              _loadInterstitialAd(); // Load next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('InterstitialAd failed to show: $error');
              ad.dispose();
              _isInterstitialAdReady = false;
              _loadInterstitialAd(); // Try loading again
            },
          );

          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          debugPrint('InterstitialAd failed to load: $error');
          _isInterstitialAdReady = false;
          notifyListeners();

          // Retry loading after a delay
          Future.delayed(const Duration(seconds: 30), () {
            _loadInterstitialAd();
          });
        },
      ),
    );
  }

  /// Show interstitial ad
  Future<void> showInterstitialAd() async {
    if (_isInterstitialAdReady && _interstitialAd != null) {
      await _interstitialAd!.show();
      _interstitialAd = null;
      _isInterstitialAdReady = false;
    } else {
      debugPrint('InterstitialAd not ready yet');
      // Load ad for next time
      _loadInterstitialAd();
    }
  }

  /// Load rewarded ad
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AppConstants.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('RewardedAd loaded successfully');
          _rewardedAd = ad;
          _isRewardedAdReady = true;

          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('RewardedAd showed');
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('RewardedAd dismissed');
              ad.dispose();
              _isRewardedAdReady = false;
              _loadRewardedAd(); // Load next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('RewardedAd failed to show: $error');
              ad.dispose();
              _isRewardedAdReady = false;
              _loadRewardedAd(); // Try loading again
            },
          );

          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          debugPrint('RewardedAd failed to load: $error');
          _isRewardedAdReady = false;
          notifyListeners();

          // Retry loading after a delay
          Future.delayed(const Duration(seconds: 30), () {
            _loadRewardedAd();
          });
        },
      ),
    );
  }

  /// Show rewarded ad
  Future<bool> showRewardedAd() async {
    if (_isRewardedAdReady && _rewardedAd != null) {
      bool rewardEarned = false;

      await _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          debugPrint('User earned reward: ${reward.amount} ${reward.type}');
          rewardEarned = true;
        },
      );

      _rewardedAd = null;
      _isRewardedAdReady = false;

      return rewardEarned;
    } else {
      debugPrint('RewardedAd not ready yet');
      // Load ad for next time
      _loadRewardedAd();
      return false;
    }
  }

  /// Dispose ads
  @override
  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }
}
