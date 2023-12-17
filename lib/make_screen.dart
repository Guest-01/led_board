import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:led_board/led_screen.dart';
import 'package:led_board/secrets.dart';
import 'package:led_board/widgets/ad_or_placeholder.dart';
import 'package:led_board/widgets/color_circle_row.dart';
import 'package:marquee/marquee.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakeScreen extends StatefulWidget {
  const MakeScreen({
    super.key,
  });

  @override
  State<MakeScreen> createState() => _MakeScreenState();
}

class _MakeScreenState extends State<MakeScreen> {
  BannerAd? _bannerAd;

  final adUnitId = bannerId;

  late SharedPreferences _prefs;

  TextEditingController controller = TextEditingController();
  List<(double size, String label)> fontSizeList = [
    // (86, '작게'),
    (128, '보통'),
    (172, '크게'),
  ];
  List<(double speed, String label)> speedList = [
    (0, '정지'),
    (100, '이동'),
    // (180, '빠름'),
  ];
  List<Color> colorList = [
    Colors.black,
    Colors.white,
    Color(Colors.amber.value)
  ];

  late double fontSize;
  late double speed;
  late Color textColor;
  late Color backgroundColor;

  late String version;

  void getLastState() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getKeys().isEmpty) return;
    setState(() {
      controller.text = _prefs.getString('text')!;
      fontSize = _prefs.getDouble('fontSize')!;
      speed = _prefs.getDouble('speed')!;
      textColor = Color(_prefs.getInt('textColor')!);
      backgroundColor = Color(_prefs.getInt('backgroundColor')!);
    });
  }

  void saveLastState() async {
    _prefs.setString('text', controller.text);
    _prefs.setDouble('fontSize', fontSize);
    _prefs.setDouble('speed', speed);
    _prefs.setInt('textColor', textColor.value);
    _prefs.setInt('backgroundColor', backgroundColor.value);
  }

  @override
  void initState() {
    super.initState();
    controller.text = "";
    fontSize = 128;
    speed = 0;
    textColor = Colors.white;
    backgroundColor = Colors.black;
    getLastState();
    version = "";
    PackageInfo.fromPlatform().then((value) {
      version = value.version;
    });
    _loadAd();
  }

  @override
  void dispose() {
    controller.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() async {
    BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade100
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    AdOrPlaceholder(ad: _bannerAd),
                    const SizedBox(height: 10),
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundColor,
                      ),
                      child: Center(
                        child: speed == 0 ||
                                controller.text
                                    .isEmpty // Marquee text should be not empty
                            ? Text(
                                controller.text,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: fontSize / 2.2, // 실제 비율에 맞추기 위함
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              )
                            : Marquee(
                                text: controller.text,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: fontSize / 2.2,
                                ),
                                velocity: speed,
                                blankSpace: 30,
                                pauseAfterRound: Duration.zero,
                                accelerationDuration: Duration.zero,
                                decelerationDuration: Duration.zero,
                              ),
                      ),
                    ),
                    const Text('미리보기'),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        hintText: '여기에 내용을 입력하세요',
                        isDense: true,
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.white10,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('글자크기'),
                        SegmentedButton<double>(
                          style: const ButtonStyle(
                            visualDensity: VisualDensity.compact,
                          ),
                          segments: [
                            for (var sizeAndLabel in fontSizeList)
                              ButtonSegment(
                                value: sizeAndLabel.$1,
                                label: Text(sizeAndLabel.$2),
                              ),
                          ],
                          selected: {fontSize},
                          onSelectionChanged: (newSelections) {
                            fontSize = newSelections.first;
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    const Divider(thickness: 0.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('글자속도'),
                        SegmentedButton<double>(
                          style: const ButtonStyle(
                            visualDensity: VisualDensity.compact,
                          ),
                          segments: [
                            for (var speedAndLabel in speedList)
                              ButtonSegment(
                                value: speedAndLabel.$1,
                                label: Text(speedAndLabel.$2),
                              ),
                          ],
                          selected: {speed},
                          onSelectionChanged: (newSelections) {
                            speed = newSelections.first;
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    const Divider(thickness: 0.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('글자색'),
                        ColorCircleRow(
                          selected: textColor,
                          colorList: colorList,
                          onSelectionChanged: (color) {
                            textColor = color;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const Divider(thickness: 0.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('배경색'),
                        ColorCircleRow(
                          selected: backgroundColor,
                          colorList: colorList,
                          onSelectionChanged: (color) {
                            backgroundColor = color;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const Divider(thickness: 0.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue.shade700,
                      ),
                      onPressed: () {
                        saveLastState();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LedScreen(
                              backgroundColor: backgroundColor,
                              textColor: textColor,
                              content: controller.text,
                              fontSize: fontSize,
                              speed: speed,
                            ),
                          ),
                        );
                      },
                      child: const Text('시작하기'),
                    ),
                  ],
                ),
              ),
              Text('v$version'),
            ],
          ),
        ),
      ),
    );
  }
}
