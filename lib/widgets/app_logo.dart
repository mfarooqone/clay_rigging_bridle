import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height, this.width, this.fit});
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoHeight = size.height;
    final logoWidth = size.width;
    final ThemeController themeController = Get.find();

    return Obx(() {
      String logoAsset;

      switch (themeController.selectedTheme.value) {
        case ThemeMode.light:
          logoAsset = AppAssets.appLogo;
          break;
        case ThemeMode.dark:
          logoAsset = AppAssets.appLogoDark;
          break;
        default:
          final Brightness brightness =
              MediaQuery.of(context).platformBrightness;
          logoAsset =
              brightness == Brightness.dark
                  ? AppAssets.appLogoDark
                  : AppAssets.appLogo;
      }

      return Image.asset(
        logoAsset,
        height: height ?? logoHeight * 0.07,
        width: width ?? logoWidth * 0.3,
        fit: fit ?? BoxFit.contain,
      );
    });
  }
}
