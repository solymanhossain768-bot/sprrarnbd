import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController controller;
  int coins = 0;
  RewardedAd? _rewardedAd;
  final String adUnitId = "ca-app-pub-3940256099942544/5224354917"; // Test ID

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
    controller = WebViewController()
     ..setJavaScriptMode(JavaScriptMode.unrestricted)
     ..loadRequest(Uri.parse('https://google.com'));
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewardedAd = ad,
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  void _showAd() {
    if (_rewardedAd!= null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          setState(() { coins += 1; });
          _loadRewardedAd();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coins: $coins = ${coins * 0.10} টাকা')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAd,
        label: Text('এড দেখে কয়েন নাও'),
        icon: Icon(Icons.play_arrow),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
