import 'package:flutter/material.dart';

sealed class LocationState extends _$LocationStateBase {
  const LocationState({
    required super.location,
    required super.localeTag,
  });

  const factory LocationState.idle({
    required String location,
    required String localeTag,
  }) = LocationState$Idle;

  const factory LocationState.processing({
    required String location,
    required String localeTag,
  }) = LocationState$Processing;

  static LocationState initialState = const LocationState.idle(
    location: '',
    localeTag: '',
  );
}

final class LocationState$Idle extends LocationState {
  const LocationState$Idle({
    required super.localeTag,
    required super.location,
  });
}

final class LocationState$Processing extends LocationState {
  const LocationState$Processing({
    required super.localeTag,
    required super.location,
  });
}

@immutable
abstract base class _$LocationStateBase {
  final String location;
  final String localeTag;

  const _$LocationStateBase({
    required this.location,
    required this.localeTag,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$LocationStateBase &&
        other.location == location &&
        other.localeTag == localeTag;
  }

  @override
  int get hashCode => location.hashCode ^ localeTag.hashCode;
}
