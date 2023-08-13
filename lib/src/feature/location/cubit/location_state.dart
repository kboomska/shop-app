import 'package:flutter/foundation.dart';

final class LocationState extends _$LocationStateBase {
  const LocationState({required super.location});

  const LocationState.initial() : super(location: '');
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
