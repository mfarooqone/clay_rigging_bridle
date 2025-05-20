import 'package:flutter/material.dart';

class AppColors {
  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;
  static const primaryColor = Color(0xFFF37E62);
  static const greyColor = Color(0xFF9CA5B0);
  static const sleepGradientTopColor = Color(0xFF2E2D2D);
  static const gradientDownColor = Color(0xFFC8D6DF);
  static const secondaryText = Color(0xffABABAB);
  static const red = Color(0xffE53D53);

  ///
  ///
  ///
  static const Color positiveColor = Color(0xFF8CC73F);
  static const Color negativeColor = Color(0xFFFF6961);
  static const Color proteinBarColor = Color(0xff6EB98F);
  static const Color carbBarColor = Color(0xffFF5A5A);
  static const Color fatBarColor = Color(0xffEBB456);

  static const Color borderColor = Color(0xffDADADA);
}

///
///
///
class AppLightThemeColors {
  static const Color gradientTopColor = Color(0xFFF1DABA);

  static const Color gradientDownColor = Color(0xFFC8D6DF);

  static const Color appBackgroundColor = Color(0xFFFFFFFF);

  static const Color secondaryButtonColor = Color(0xFFEEEFF1);

  static const Color primaryTextColor = Color(0xFF000229);

  static const Color primaryButtonTextColor = Color(0xFFFFFFFF);

  static const Color secondaryButtonTextColor = AppColors.primaryColor;

  static const Color lightGreyColor = Color(0xFFEEEFF1);

  static const Color bottomSheetColor = Color(0xFFFFFFFF);

  static const Color iconColor = primaryTextColor;
}

///
///
///
class AppDarkThemeColors {
  static Color gradientTopColor =
      const Color(0xFF4A4F4E).withValues(alpha: 0.35);

  static Color gradientDownColor =
      const Color(0xFFF1DABA).withValues(alpha: 0.40);

  static const Color appBackgroundColor = Color(0xFF2E2E2E);

  static const Color secondaryButtonColor = Color(0xFFEEEFF1);

  static const Color primaryTextColor = Color(0xFFFFFFFF);

  static const Color primaryButtonTextColor = Color(0xFFFFFFFF);

  static const Color secondaryButtonTextColor = AppColors.primaryColor;

  static const Color lightGreyColor = Color(0xFF454545);

  static const Color bottomSheetColor = Color(0xFF393939);

  static const Color iconColor = primaryTextColor;
}
