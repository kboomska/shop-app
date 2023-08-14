import 'package:flutter/material.dart';

sealed class LocationState extends _$LocationStateBase {
  const LocationState({
    required super.location,
    required super.locale,
  });

  const factory LocationState.idle({
    required String location,
    required Locale locale,
  }) = LocationState$Idle;

  const factory LocationState.processing({
    required String location,
    required Locale locale,
  }) = LocationState$Processing;

  static LocationState initialState = const LocationState.idle(
    location: '',
    locale: Locale('und'),
  );
}

final class LocationState$Idle extends LocationState {
  const LocationState$Idle({
    required super.locale,
    required super.location,
  });
}

final class LocationState$Processing extends LocationState {
  const LocationState$Processing({
    required super.locale,
    required super.location,
  });
}

@immutable
abstract base class _$LocationStateBase {
  final String location;
  final Locale locale;

  const _$LocationStateBase({
    required this.location,
    required this.locale,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$LocationStateBase &&
        other.location == location &&
        other.locale == locale;
  }

  @override
  int get hashCode => location.hashCode ^ locale.hashCode;
}
