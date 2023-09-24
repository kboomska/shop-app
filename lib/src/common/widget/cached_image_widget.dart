import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:shop_app_bloc/src/common/theme/app_typography.dart';
import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;

  const CachedImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return _ImageWidget(imageProvider: imageProvider);
      },
      placeholder: (context, url) {
        return const Center(
          child: Text(
            'Загрузка...',
            style: AppTypography.subhead1,
          ),
        );
      },
      errorWidget: (context, url, error) {
        return const Icon(
          Icons.error,
          size: 48,
          color: AppColors.appCacheErrorIcon,
        );
      },
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final ImageProvider imageProvider;

  const _ImageWidget({required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
