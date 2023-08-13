import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/common/localization/localization_storage.dart';

abstract interface class ILocalizationDataProvider {
  bool isLocaleUpdated(Locale locale);
  String get localeTag;
  Locale get locale;
}

final class LocalizationDataProviderImpl implements ILocalizationDataProvider {
  final ILocalizationStorage _localizationStorage;

  LocalizationDataProviderImpl(
      {required ILocalizationStorage localizationStorage})
      : _localizationStorage = localizationStorage;

  @override
  bool isLocaleUpdated(Locale locale) {
    return _localizationStorage.isLocaleUpdated(locale);
  }

  @override
  String get localeTag => _localizationStorage.localeTag;

  @override
  Locale get locale => _localizationStorage.locale;
}
