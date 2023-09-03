import 'package:flutter/foundation.dart' as foundation;
import 'package:meta/meta.dart';

import 'package:shop_app_bloc/src/feature/dishes/model/dish_tag.dart';
import 'package:shop_app_bloc/src/feature/dishes/model/dish.dart';

sealed class DishesState extends _$DishesStateBase {
  const DishesState({
    required super.dishes,
    required super.tags,
  });

  const factory DishesState.idle({
    required List<Dish> dishes,
    required List<DishTag> tags,
    String? error,
  }) = DishesState$Idle;

  const factory DishesState.processing({
    required List<Dish> dishes,
    required List<DishTag> tags,
  }) = DishesState$Processing;

  static const DishesState initialState = DishesState.idle(
    dishes: <Dish>[],
    tags: <DishTag>[
      DishTag(name: 'Все меню', isSelected: true),
      DishTag(name: 'Салаты', isSelected: false),
      DishTag(name: 'С рисом', isSelected: false),
      DishTag(name: 'С рыбой', isSelected: false),
    ],
    error: null,
  );
}

final class DishesState$Idle extends DishesState {
  const DishesState$Idle({
    required super.dishes,
    required super.tags,
    this.error,
  });

  @override
  final String? error;
}

final class DishesState$Processing extends DishesState {
  const DishesState$Processing({
    required super.dishes,
    required super.tags,
  });

  @override
  String? get error => null;
}

@immutable
abstract base class _$DishesStateBase {
  final List<Dish> dishes;
  final List<DishTag> tags;
  abstract final String? error;

  const _$DishesStateBase({
    required this.dishes,
    required this.tags,
  });

  bool get hasError => error != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$DishesStateBase &&
        foundation.listEquals(other.dishes, dishes) &&
        foundation.listEquals(other.tags, tags) &&
        other.error == error;
  }

  @override
  int get hashCode => dishes.hashCode ^ tags.hashCode ^ error.hashCode;
}
