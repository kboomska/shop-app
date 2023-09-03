sealed class DishesEvent extends _$DishesEventBase {}

final class DishesEvent$Load extends DishesEvent {}

final class DishesEvent$Reset extends DishesEvent {}

final class DishesEvent$OnTapTag extends DishesEvent {
  final int index;

  DishesEvent$OnTapTag({
    required this.index,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DishesEvent$OnTapTag && other.index == index;
  }

  @override
  int get hashCode => index.hashCode;
}

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
