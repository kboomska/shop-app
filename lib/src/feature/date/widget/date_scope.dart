import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DateScope extends StatefulWidget {
  const DateScope({
    required this.child,
    super.key,
  });

  final Widget child;

  static String dateOf(BuildContext context, {bool listen = true}) =>
      _InheritedDateScope.of(context, listen: listen).date;

  @override
  State<DateScope> createState() => _DateScopeState();
}

class _DateScopeState extends State<DateScope> {
  late DateFormat _dateFormat;
  late DateFormat _yearFormat;
  String _localeTag = '';
  String _date = '';
  Timer? _dateTimer;

  @override
  void initState() {
    super.initState();
    log('DateScope: Created');
    _dateTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _onDateChanged(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    _onLocaleChanged(locale);
  }

  @override
  void dispose() {
    super.dispose();
    _dateTimer?.cancel();
    log('DateScope: Disposed');
  }

  _onDateChanged() {
    final now = DateTime.now();
    final String date =
        '${_dateFormat.format(now)}, ${_yearFormat.format(now)}';
    if (date == _date) return;

    setState(() {
      log('DateScope: It\'s a new day - $date');
      _date = date;
    });
  }

  void _onLocaleChanged(Locale locale) {
    final localeTag = locale.toLanguageTag();
    if (localeTag == _localeTag) return;

    _dateFormat = DateFormat.MMMMd(localeTag);
    _yearFormat = DateFormat.y(localeTag);

    final now = DateTime.now();
    final String date =
        '${_dateFormat.format(now)}, ${_yearFormat.format(now)}';

    setState(() {
      log('DateScope: Locale changed from $_localeTag to: $localeTag');
      _date = date;
      _localeTag = localeTag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedDateScope(
      date: _date,
      child: widget.child,
    );
  }
}

class _InheritedDateScope extends InheritedWidget {
  const _InheritedDateScope({
    required this.date,
    required super.child,
  });

  final String date;

  static _InheritedDateScope? maybeOf(BuildContext context,
          {bool listen = true}) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<_InheritedDateScope>()
          : context.getInheritedWidgetOfExactType<_InheritedDateScope>();

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget a _InheritedDateScope of the exact type',
        'out_of_scope',
      );

  static _InheritedDateScope of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(_InheritedDateScope oldWidget) {
    return !identical(date, oldWidget.date);
  }
}
