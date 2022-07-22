import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/common_numer.dart';

import '../History/error_box.dart';
import 'build_box.dart';
import 'date_change_notification.dart';

import '../../services/ad_helper.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class BodyCommonNumber extends StatefulWidget {
  const BodyCommonNumber({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyCommonNumber> createState() => _BodyCommonNumberState();
}

class _BodyCommonNumberState extends State<BodyCommonNumber> {
  DateTime selectedDate = DateTime.now();

  BannerAd? _bannerAd;
  @override
  void initState() {
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

    super.initState();
  }

  @override
  dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<CommonNumberModel?>? _data =
        Provider.of<List<CommonNumberModel?>?>(context);

    return Column(
      children: [
        const Text(
          'Common Number',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        _data!.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 80),
                child: ErrorBox(
                  errorMessage: 'No Data Found',
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _data
                      .map(
                        (e) => BuildBox(
                          selectedDate: selectedDate,
                          commonNumber: e!.commonNumber,
                          provider: e.provider,
                          house: e.house,
                          ending: e.ending,
                        ),
                      )
                      .toList(),

                  // for (final item in _data)
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            _selectDate(context);
          },
          child: const Text(
            'Select Date',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            minimumSize: MaterialStateProperty.all(
                Size(size.width * 0.8, size.height * 0.06)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
          ),
        ),
        //Display Banner Add here

        if (_bannerAd != null)
          Center(
            child: SizedBox(
              width: _bannerAd?.size.width.toDouble(),
              height: _bannerAd?.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          ),

        //&************Utility for adding docs in bulk
        // TextButton(
        //     onPressed: () {
        //       DatabaseService().addDoc();
        //     },
        //     child: const Text('ADD DATA'))
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 600)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        DateChangeNotfication(date: selectedDate).dispatch(context);
      });
    }
  }
}
