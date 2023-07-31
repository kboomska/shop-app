sealed class CategoriesEvent extends _$CategoriesEventBase {}

final class CategoriesEvent$Load extends CategoriesEvent {}

final class CategoriesEvent$Reset extends CategoriesEvent {}

abstract base class _$CategoriesEventBase {
  const _$CategoriesEventBase();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$CategoriesEventBase && other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => 0;
}
