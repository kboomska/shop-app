import 'package:flutter/foundation.dart';

sealed class LocationState extends _$LocationStateBase {
  const LocationState({required super.location});

  const factory LocationState.idle({required String location}) =
      LocationState$Idle;

  const factory LocationState.processing({required String location}) =
      LocationState$Processing;

  static const LocationState initialState = LocationState.idle(
    location: '',
  );
}

final class LocationState$Idle extends LocationState {
  const LocationState$Idle({required super.location});
}

final class LocationState$Processing extends LocationState {
  const LocationState$Processing({required super.location});

  @override
  String get location => 'Определяем местоположение...';
}

@immutable
abstract base class _$LocationStateBase {
  final String location;

  const _$LocationStateBase({required this.location});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$LocationStateBase && other.location == location;
  }

  @override
  int get hashCode => location.hashCode;
}
