import 'package:flutter/material.dart';

abstract interface class ILocalizationStorage {
  bool isLocaleUpdated(Locale locale);
  String get localeTag;
}

final class LocalizationStorageImpl implements ILocalizationStorage {
  String _localeTag = '';

  @override
  String get localeTag => _localeTag;

  @override
  bool isLocaleUpdated(Locale locale) {
    final localeTag = locale.toLanguageTag();

    if (_localeTag == localeTag) return false;
    _localeTag = localeTag;
    return true;
  }
}
