import 'package:flutter/foundation.dart';

final class DateState extends _$DateStateBase {
  const DateState({
    required super.localTag,
    required super.date,
  });

  const DateState.initial() : super(localTag: '', date: '');
}

@immutable
abstract base class _$DateStateBase {
  final String localTag;
  final String date;

  const _$DateStateBase({
    required this.localTag,
    required this.date,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$DateStateBase &&
        other.localTag == localTag &&
        other.date == date;
  }

  @override
  int get hashCode => localTag.hashCode ^ date.hashCode;
}
