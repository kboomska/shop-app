import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

class DishTag {
  final String name;
  final bool isSelected;
  Color get titleColor => isSelected
      ? AppColors.dishTagTextSelected
      : AppColors.dishTagTextUnselected;

  Color get backgroundColor => isSelected
      ? AppColors.dishTagBackgroundSelected
      : AppColors.dishTagBackgroundUnselected;

  const DishTag({
    required this.name,
    required this.isSelected,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DishTag &&
        other.name == name &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return name.hashCode ^ isSelected.hashCode;
  }

  DishTag copyWith({
    String? name,
    bool? isSelected,
  }) {
    return DishTag(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
