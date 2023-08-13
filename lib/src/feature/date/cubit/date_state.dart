import 'package:flutter/foundation.dart';

final class DateState extends _$DateStateBase {
  const DateState({
    required super.date,
  });

  const DateState.initial() : super(date: '');
}

@immutable
abstract base class _$DateStateBase {
  final String date;

  const _$DateStateBase({
    required this.date,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$DateStateBase && other.date == date;
  }

  @override
  int get hashCode => date.hashCode;
}
