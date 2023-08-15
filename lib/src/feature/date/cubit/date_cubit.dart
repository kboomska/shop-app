import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:shop_app_bloc/src/feature/date/cubit/date_state.dart';

final class DateCubit extends Cubit<DateState> {
  DateCubit({
    DateState? initialState,
  }) : super(initialState ?? const DateState.initial());

  void getDate(Locale locale) {
    final localeTag = locale.toLanguageTag();
    if (localeTag == state.localeTag) return;

    final dateFormatted = DateFormat.MMMMd(localeTag).format(DateTime.now());
    final yearFormatted = DateFormat.y(localeTag).format(DateTime.now());

    final String date = '$dateFormatted, $yearFormatted';

    emit(DateState(date: date, localeTag: localeTag));
  }
}
