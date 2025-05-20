import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? iconSize;
  final double? textSize;
  final Color? iconColor;
  final Color? textColor;
  final FontWeight? textWeight;
  final double? spacing;

  const IconTextRow({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize,
    this.textSize,
    this.iconColor,
    this.textColor,
    this.textWeight,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Icon(
          icon,
          size: iconSize ?? 20,
          color:  iconColor?? appTheme.hintColor,
        ),
        SizedBox(width: spacing ?? size.width * 0.01),
        Text(
          text,
          style: AppTextStyle.headlineMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w600 , color: appTheme.hintColor),
        ),
      ],
    );
  }
}
