import 'package:clay_rigging_bridle/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ImageDarkLight extends StatelessWidget {
  const ImageDarkLight({
    super.key,
    this.height,
    this.width,
    this.fit,
    this.image,
    this.svgImage = true,
    this.darkImage,
  });

  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? image;
  final String? darkImage;
  final bool? svgImage;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      String logoAsset;

      switch (themeController.selectedTheme.value) {
        case ThemeMode.light:
          logoAsset = image ?? "";
          break;
        case ThemeMode.dark:
          logoAsset = darkImage ?? "";
          break;

        default:
          final Brightness brightness =
              MediaQuery.of(context).platformBrightness;
          logoAsset =
              brightness == Brightness.dark ? darkImage ?? "" : image ?? "";
      }

      return svgImage == true
          ? SvgPicture.asset(
            logoAsset,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
          )
          : Image.asset(
            logoAsset,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
          );
    });
  }
}
