import 'package:flutter/material.dart';
import 'package:led_board/widgets/color_circle.dart';

class ColorCircleRow extends StatefulWidget {
  final Color selected;
  final List<Color> colorList;
  final Function(Color) onSelectionChanged;

  const ColorCircleRow({
    super.key,
    required this.selected,
    required this.colorList,
    required this.onSelectionChanged,
  });

  @override
  State<ColorCircleRow> createState() => _ColorCircleRowState();
}

class _ColorCircleRowState extends State<ColorCircleRow> {
  late int selectedIdx;

  @override
  void initState() {
    super.initState();
    selectedIdx =
        widget.colorList.indexWhere((element) => element == widget.selected);
  }

  @override
  void didUpdateWidget(covariant ColorCircleRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedIdx =
        widget.colorList.indexWhere((element) => element == widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var (idx, color) in widget.colorList.indexed) ...[
          ColorCircle(
            isActive: idx == selectedIdx,
            color: color,
            onTap: (color) {
              selectedIdx = idx;
              widget.onSelectionChanged(color);
              setState(() {});
            },
          ),
          if (idx != widget.colorList.length - 1) const SizedBox(width: 5),
        ]
      ],
    );
  }
}
