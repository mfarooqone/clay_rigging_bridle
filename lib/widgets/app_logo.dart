import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:flutter/material.dart';

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

    return Image.asset(
      AppAssets.appLogo,
      height: height ?? logoHeight * 0.07,
      width: width ?? logoWidth * 0.3,
      fit: fit ?? BoxFit.contain,
    );
  }
}
