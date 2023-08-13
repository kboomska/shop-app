import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shop_app_bloc/src/common/router/app_navigation_route_names.dart';
import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

abstract interface class IAppNavigation {
  Route<Object> onGenerateRoute(RouteSettings settings);
  Map<String, Widget Function(BuildContext)> get routes;
}

class App extends StatelessWidget {
  final IAppNavigation navigation;

  const App({super.key, required this.navigation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      ],
      routes: navigation.routes,
      initialRoute: AppNavigationRouteNames.home,
    );
  }
}
