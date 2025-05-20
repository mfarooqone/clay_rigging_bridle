import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.white.withValues(alpha: 0.3),
      ),
      child: Center(child: Image.asset(AppAssets.loader, width: 80)),
    );
  }
}

///
///
///
///
class ImageLoadingIndicator extends StatelessWidget {
  const ImageLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return SizedBox(
      width: width,
      height: height,
      child: Center(child: Image.asset(AppAssets.loader, width: 30)),
    );
  }
}
