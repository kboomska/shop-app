import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

const mainFontFamily = 'SFProDisplay';

abstract final class AppTypography {
  static const headline1 = TextStyle(
    color: AppColors.textHeadline,
    fontWeight: FontWeight.w500,
    fontFamily: mainFontFamily,
    fontSize: 18,
    height: 1.2,
  );

  static const subhead1 = TextStyle(
    color: AppColors.textSubhead,
    fontWeight: FontWeight.w400,
    fontFamily: mainFontFamily,
    fontSize: 14,
    height: 1.15,
  );

  static const headlineCategory = TextStyle(
    color: AppColors.textHeadline,
    fontWeight: FontWeight.w500,
    fontFamily: mainFontFamily,
    letterSpacing: 0.2,
    fontSize: 20,
    height: 1.25,
  );

  static const headlineDishItem = TextStyle(
    color: AppColors.textHeadline,
    fontWeight: FontWeight.w400,
    fontFamily: mainFontFamily,
    fontSize: 14,
    height: 1.05,
  );

  static TextStyle headlineDishTag(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: mainFontFamily,
        fontSize: 14,
        height: 1.05,
      );
}
