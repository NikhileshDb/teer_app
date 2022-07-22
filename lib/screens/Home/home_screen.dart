import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:teer_common/screens/Home/latest_result_card.dart';
import 'package:teer_common/services/ad_helper.dart';
import 'package:update_notification/screens/update_notification.dart';
import '../../global_components/navigation_drawer_widget.dart';
import '../../global_components/reusable_sliver.dart';
import '../../services/firebase_messaging.dart';
import '../../services/push_notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InterstitialAd? _interstitialAd;
  BannerAd? _bannerAd;
  bool isInterstitialAdReady = false;
  void _loadInterestitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              //ToDo
              // Navigator.of(context).pop();
            },
          );
          setState(() {
            _interstitialAd = ad;
            isInterstitialAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          // print('Failed to load an interstitial add: ${err.message}');
        },
      ),
    );
  }

  // Firebase cloud messaging
  @override
  void initState() {
    _loadInterestitialAd();
    showInterstitialAd();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(
            () {
              _bannerAd = ad as BannerAd;
            },
          );
        },
        onAdFailedToLoad: (ad, err) {
          // print('Failed to load a banner ad:  + ${err.message}');
          ad.dispose();
        },
      ),
    ).load();

    //update notification
    final UpdateNotification updateNotification = UpdateNotification(
        androidAppId: 'com.teerapp.app', minimumVersion: '1.0.9');
    showPopDialog(updateNotification);
    super.initState();
    fireBaseMessagingService(context);
  }

  void showPopDialog(UpdateNotification updateVersion) {
    updateVersion.showAlertDialog(context: context);
  }

  @override
  dispose() {
    _interstitialAd?.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  void showInterstitialAd() {
    Timer(const Duration(seconds: 5), () {
      if (_interstitialAd != null) {
        _interstitialAd?.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);
    // final teerResults = Provider.of<List<TeerResult>>(context);
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      extendBody: true,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          const ReusableSliverAppBar(),
          // buildList(),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const LatestResultCard(providerName: 'Shillong Teer'),
                  const LatestResultCard(providerName: 'Juwai'),
                  const LatestResultCard(providerName: 'Khanapara'),
                  if (_bannerAd != null)
                    Center(
                      child: SizedBox(
                        width: _bannerAd?.size.width.toDouble(),
                        height: _bannerAd?.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
