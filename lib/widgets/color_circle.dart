import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  final bool isActive;
  final bool isLocked;
  final Color color;
  final Function(Color) onTap;

  const ColorCircle({
    super.key,
    required this.isActive,
    this.isLocked = false,
    required this.color,
    required this.onTap,
  });

  Widget? _makeIcon(BuildContext context) {
    if (isLocked) {
      return const Icon(
        Icons.lock,
        color: Colors.black54,
      );
    }
    if (isActive) {
      return Icon(Icons.check, color: Theme.of(context).primaryColor);
    }
    return null;
  }

  Border? _makeBorder(BuildContext context) {
    if (isLocked) {
      return Border.all(width: 2, color: Colors.black54);
    }
    if (isActive) {
      return Border.all(width: 2, color: Theme.of(context).primaryColor);
    }
    return Border.all(width: 1, color: Colors.black54);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(color);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: _makeBorder(context),
        ),
        child: _makeIcon(context),
      ),
    );
  }
}
