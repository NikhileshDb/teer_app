import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:teer_common/services/ad_helper.dart';

import '../screens/Common/common_screen.dart';

import '../screens/History/result_history.dart';
import '../screens/Home/home_screen.dart';

class NavigationCurved extends StatefulWidget {
  const NavigationCurved({Key? key}) : super(key: key);

  @override
  State<NavigationCurved> createState() => _NavigationCurvedState();
}

class _NavigationCurvedState extends State<NavigationCurved> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  List<StatefulWidget> screens = [
    const HomeScreen(),
    const HistoryScreen(),
    const CommoNumberScreen(),
  ];
  bool isInterstitialAdReady = false;
  InterstitialAd? _interstitialAd;
  void _loadInterestitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              //ToDo
              // Navigator.of(context).pop();
            },
          );
          isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial add: ${err.message}');
        },
      ),
    );
  }

  @override
  initState() {
    _loadInterestitialAd();
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.home,
        size: 30,
        color: Colors.white,
      ),
      const Icon(
        Icons.history,
        size: 30,
        color: Colors.white,
      ),
      const Icon(
        Icons.comment_bank,
        size: 30,
        color: Colors.white,
      ),
    ];
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.black,
            body: IndexedStack(
              index: index,
              children: screens,
            ),
            bottomNavigationBar: CurvedNavigationBar(
              key: navigationKey,
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              color: Colors.black,
              height: 50,
              index: index,
              items: items,
              onTap: (index) {
                if (_interstitialAd != null) {
                  _interstitialAd!.show();
                }
                setState(() => this.index = index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
