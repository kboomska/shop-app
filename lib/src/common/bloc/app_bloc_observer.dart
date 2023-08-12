import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('${bloc.runtimeType}: Created');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('${bloc.runtimeType}: ${event.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    final currentState = transition.currentState;
    final nextState = transition.nextState;
    log('${bloc.runtimeType}: ${currentState.runtimeType} -> ${nextState.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('${bloc.runtimeType}: $error $stackTrace');
    log('$stackTrace');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('${bloc.runtimeType}: Closed');
  }
}
