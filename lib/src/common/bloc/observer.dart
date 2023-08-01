import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc.observer = Observer();
class Observer extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('Observer: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('Observer: ${change.currentState} -> ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('Observer: $error');
  }
}
