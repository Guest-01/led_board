import 'package:flutter/material.dart';
import 'package:led_board/widgets/color_circle.dart';

class ColorCircleRow extends StatefulWidget {
  final Color initial;
  final List<Color> colorList;
  final Function(Color) onChange;

  const ColorCircleRow({
    super.key,
    required this.initial,
    required this.colorList,
    required this.onChange,
  });

  @override
  State<ColorCircleRow> createState() => _ColorCircleRowState();
}

class _ColorCircleRowState extends State<ColorCircleRow> {
  late int selected;

  @override
  void initState() {
    super.initState();
    selected =
        widget.colorList.indexWhere((element) => element == widget.initial);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var (idx, color) in widget.colorList.indexed) ...[
          ColorCircle(
            isActive: idx == selected,
            color: color,
            onTap: (color) {
              selected = idx;
              widget.onChange(color);
              setState(() {});
            },
          ),
          if (idx != widget.colorList.length - 1) const SizedBox(width: 5),
        ]
      ],
    );
  }
}
