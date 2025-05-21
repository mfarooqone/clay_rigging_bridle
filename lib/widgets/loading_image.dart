import 'package:cached_network_image/cached_network_image.dart';
import 'package:clay_rigging_bridle/utils/app_colors.dart';
import 'package:clay_rigging_bridle/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  final BoxFit? fit;
  final bool? profileImage;

  const LoadingImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.profileImage = false,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      fadeOutDuration: const Duration(milliseconds: 500),
      placeholder:
          (context, url) => const Center(child: ImageLoadingIndicator()),
      errorWidget:
          (context, url, error) => Center(
            child:
                profileImage == true
                    ? Image.network(
                      height: 40,
                      'https://cdn-icons-png.flaticon.com/512/2815/2815428.png',
                      fit: BoxFit.cover,
                      color: AppColors.primaryColor,
                    )
                    : ImageLoadingIndicator(),
          ),
    );
  }
}
