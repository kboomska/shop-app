sealed class DishesEvent extends _$DishesEventBase {}

final class DishesEvent$Load extends DishesEvent {}

final class DishesEvent$Reset extends DishesEvent {}

abstract base class _$DishesEventBase {
  const _$DishesEventBase();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$DishesEventBase && other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => 0;
}
