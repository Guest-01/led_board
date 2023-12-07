import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LedScreen extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final String content;

  const LedScreen({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.content,
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
        child: Text(
          widget.content,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 148,
          ),
        ),
      ),
    );
  }
}
