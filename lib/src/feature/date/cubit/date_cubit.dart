import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:shop_app_bloc/src/common/localization/localization_storage.dart';
import 'package:shop_app_bloc/src/feature/date/cubit/date_state.dart';

class DateCubit extends Cubit<DateState> {
  final ILocalizationStorage _localizationStorage;

  late DateFormat _dateFormat;
  late DateFormat _yearFormat;

  DateCubit({
    required ILocalizationStorage localizationStorage,
    DateState? initialState,
  })  : _localizationStorage = localizationStorage,
        super(initialState ?? const DateState.initial());

  void _setupLocale(Locale locale) {
    if (!_localizationStorage.isLocaleUpdated(locale)) return;

    _dateFormat = DateFormat.MMMMd(_localizationStorage.localeTag);
    _yearFormat = DateFormat.y(_localizationStorage.localeTag);
  }

  void setupDate(Locale locale) {
    _setupLocale(locale);
    final String localTag = locale.toLanguageTag();
    final String date =
        '${_dateFormat.format(DateTime.now())}, ${_yearFormat.format(DateTime.now())}';
    emit(DateState(localTag: localTag, date: date));
  }
}
