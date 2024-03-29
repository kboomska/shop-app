import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

abstract interface class IAppNavigation {
  RouterConfig<Object> get router;
}

class App extends StatelessWidget {
  final IAppNavigation navigation;

  const App({super.key, required this.navigation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFProDisplay',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBackground,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.bottomNavigationBarBackground,
          selectedItemColor: AppColors.bottomNavigationBarSelected,
          unselectedItemColor: AppColors.bottomNavigationBarUnselected,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'EN'),
      ],
      routerConfig: navigation.router,
      // routeInformationParser: navigation.router.routeInformationParser,
      // routerDelegate: navigation.router.routerDelegate,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
