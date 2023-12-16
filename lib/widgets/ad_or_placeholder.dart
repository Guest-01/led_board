import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdOrPlaceholder extends StatelessWidget {
  final BannerAd? ad;

  const AdOrPlaceholder({
    super.key,
    required this.ad,
  });

  @override
  Widget build(BuildContext context) {
    if (ad != null) {
      return SizedBox(
        height: ad!.size.height.toDouble(),
        child: AdWidget(ad: ad!),
      );
    }

    return const Placeholder(
      color: Colors.grey,
      strokeWidth: 2,
      child: SizedBox(
        width: 320,
        height: 50,
        child: Center(child: Text('Google Ads')),
      ),
    );
  }
}
