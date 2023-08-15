import 'package:flutter/foundation.dart';

final class DateState extends _$DateStateBase {
  const DateState({
    required super.date,
    required super.localeTag,
  });

  const DateState.initial() : super(date: '', localeTag: '');
}

@immutable
abstract base class _$DateStateBase {
  final String date;
  final String localeTag;

  const _$DateStateBase({
    required this.date,
    required this.localeTag,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$DateStateBase &&
        other.date == date &&
        other.localeTag == localeTag;
  }

  @override
  int get hashCode => date.hashCode ^ localeTag.hashCode;
}
