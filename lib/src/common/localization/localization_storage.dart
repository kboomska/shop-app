import 'package:flutter/material.dart';

abstract interface class ILocalizationStorage {
  bool isLocaleUpdated(Locale locale);
  String get localeTag;
  Locale get locale;
}

final class LocalizationStorageImpl implements ILocalizationStorage {
  Locale _locale = const Locale('en');

  @override
  String get localeTag => _locale.toLanguageTag();

  @override
  Locale get locale => _locale;

  @override
  bool isLocaleUpdated(Locale locale) {
    if (_locale == locale) return false;
    _locale = locale;
    print(locale.toLanguageTag());
    return true;
  }
}
