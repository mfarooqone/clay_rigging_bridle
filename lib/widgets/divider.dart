import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;

  const DividerWidget({
    super.key,
    required this.width,
    required this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      color: color ?? theme.dividerColor,
    );
  }
}
