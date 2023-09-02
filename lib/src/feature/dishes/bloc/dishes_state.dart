import 'package:flutter/foundation.dart' as foundation;
import 'package:meta/meta.dart';

import 'package:shop_app_bloc/src/feature/dishes/model/dish.dart';

sealed class DishesState extends _$DishesStateBase {
  const DishesState({required super.dishes});

  const factory DishesState.idle({
    required List<Dish> dishes,
    String? error,
  }) = DishesState$Idle;

  const factory DishesState.processing({
    required List<Dish> dishes,
  }) = DishesState$Processing;

  static const DishesState initialState = DishesState.idle(
    dishes: <Dish>[],
    error: null,
  );
}

final class DishesState$Idle extends DishesState {
  const DishesState$Idle({required super.dishes, this.error});

  @override
  final String? error;
}

final class DishesState$Processing extends DishesState {
  const DishesState$Processing({required super.dishes});

  @override
  String? get error => null;
}

@immutable
abstract base class _$DishesStateBase {
  final List<Dish> dishes;
  abstract final String? error;

  const _$DishesStateBase({
    required this.dishes,
  });

  bool get hasError => error != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$DishesStateBase &&
        foundation.listEquals(other.dishes, dishes) &&
        other.error == error;
  }

  @override
  int get hashCode => dishes.hashCode ^ error.hashCode;
}
