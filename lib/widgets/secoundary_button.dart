import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class SecondaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String label;

  const SecondaryButton({
    super.key,
    this.height,
    this.width,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: height ?? size.height * 0.04, // Use provided height or default
      width: width ?? size.width * 0.22,     // Use provided width or default
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: const Color(0xFFABABAB)),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
