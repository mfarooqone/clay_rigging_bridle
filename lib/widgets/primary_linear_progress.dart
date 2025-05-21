import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PrimaryLinearProgress extends StatelessWidget {
  const PrimaryLinearProgress({
    super.key,
    required this.progress,
    required this.progressText,
  });
  final double progress;

  final String progressText;

  @override
  Widget build(BuildContext context) {
    // final appTheme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(progressText, style: AppTextStyle.bodySmall),

        ///
        const SizedBox(height: 10),

        ///
        ///
        Padding(
          padding: const EdgeInsets.all(0.1),
          child: LinearPercentIndicator(
            width: width * 0.60,
            animation: true,
            lineHeight: height * 0.01,
            animationDuration: 500,
            percent: progress,
            backgroundColor: AppColors.white,
            barRadius: const Radius.circular(20),
            progressColor: AppColors.primaryColor,
            alignment: MainAxisAlignment.center,
            padding: const EdgeInsets.all(0),
          ),
        ),
        const SizedBox(height: 10),

        ///
        Text(
          "${(progress * 100).toInt()}%",
          style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: height * 0.01),
      ],
    );
  }
}
