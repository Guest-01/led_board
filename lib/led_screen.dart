import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';

class LedScreen extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final String content;
  final double fontSize;
  final double speed;

  const LedScreen({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.content,
    required this.fontSize,
    required this.speed,
  });

  @override
  State<LedScreen> createState() => _LedScreenState();
}

class _LedScreenState extends State<LedScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: widget.speed == 0 || widget.content.isEmpty
            ? Text(
                widget.content,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1,
              )
            : Marquee(
                text: widget.content,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                ),
                velocity: widget.speed + 30, // 미리보기보다 조금 느림
                blankSpace: 30,
              ),
      ),
    );
  }
}
