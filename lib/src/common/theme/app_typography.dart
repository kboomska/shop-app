import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

const mainFontFamily = 'SFProDisplay';

abstract final class AppTypography {
  static const headline1 = TextStyle(
    color: AppColors.textHeadline,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.2,
    fontFamily: mainFontFamily,
  );

  static const subhead1 = TextStyle(
    color: AppColors.textSubhead,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.15,
    fontFamily: mainFontFamily,
  );

  static const headlineCategory = TextStyle(
    color: AppColors.textHeadline,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1.25,
    letterSpacing: 0.2,
    fontFamily: mainFontFamily,
  );
}
