import 'package:clay_rigging_bridle/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

///
///
///
void showSuccessMessage(
  String message, {
  ScaffoldMessengerState? messengerState,
}) {
  final s = messengerState ?? ScaffoldMessenger.of(Get.context!);
  s.showSnackBar(
    SnackBar(content: Text(message), backgroundColor: AppColors.positiveColor),
  );
}

///
///
///
void showErrorMessage(
  String message, {
  ScaffoldMessengerState? messengerState,
}) {
  final s = messengerState ?? ScaffoldMessenger.of(Get.context!);
  s.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.nunitoSans(
          textStyle: const TextStyle(color: AppColors.white),
        ),
      ),
      backgroundColor: AppColors.negativeColor,
    ),
  );
}
