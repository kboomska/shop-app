import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/common/dependencies/di_container.dart';
import 'package:shop_app_bloc/src/common/bloc/app_bloc_observer.dart';

abstract interface class IAppFactory {
  Widget makeApp();
}

void main() {
  runZonedGuarded(() {
    final appFactory = makeAppFactory();
    final app = appFactory.makeApp();

    Bloc.observer = AppBlocObserver();

    runApp(app);
  }, (error, stackTrace) {
    log(error.toString(), stackTrace: stackTrace);
  });
}
