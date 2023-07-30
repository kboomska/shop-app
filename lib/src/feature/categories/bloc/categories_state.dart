import 'package:flutter/foundation.dart' as foundation;

import 'package:shop_app_bloc/src/feature/categories/model/category.dart';

sealed class CategoriesState extends _$CategoriesStateBase {
  const CategoriesState({required super.categories});

  const factory CategoriesState.idle({
    required List<Category> categories,
    String? error,
  }) = CategoriesState$Idle;

  const factory CategoriesState.processing({
    required List<Category> categories,
  }) = CategoriesState$Processing;
}

final class CategoriesState$Idle extends CategoriesState {
  const CategoriesState$Idle({required super.categories, this.error});

  @override
  final String? error;
}

final class CategoriesState$Processing extends CategoriesState {
  const CategoriesState$Processing({required super.categories});

  @override
  String? get error => null;
}

abstract base class _$CategoriesStateBase {
  final List<Category> categories;
  abstract final String? error;

  const _$CategoriesStateBase({
    required this.categories,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$CategoriesStateBase &&
        foundation.listEquals(other.categories, categories) &&
        other.error == error;
  }

  @override
  int get hashCode => categories.hashCode ^ error.hashCode;
}
