import 'dart:developer';

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
  String _localeTag = '';
  String _date = '';

  @override
  void initState() {
    super.initState();
    log('DateScope: Created');
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
    log('DateScope: Disposed');
  }

  void _onLocaleChanged(Locale locale) {
    final localeTag = locale.toLanguageTag();
    if (localeTag == _localeTag) return;

    final dateFormatted = DateFormat.MMMMd(localeTag).format(DateTime.now());
    final yearFormatted = DateFormat.y(localeTag).format(DateTime.now());

    final String date = '$dateFormatted, $yearFormatted';
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
        'Out of scope, not found inherited widget '
            'a _InheritedDateScope of the exact type',
        'out_of_scope',
      );

  static _InheritedDateScope of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(_InheritedDateScope oldWidget) {
    return !identical(date, oldWidget.date);
  }
}
