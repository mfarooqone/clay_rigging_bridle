import 'package:clay_rigging_bridle/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap:
              onPressed ??
              () {
                Get.back();
              },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
    );
  }
}
