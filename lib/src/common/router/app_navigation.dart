import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/common/router/app_navigation_route_names.dart';
import 'package:shop_app_bloc/src/common/widget/app.dart';

abstract interface class IScreenFactory {
  Widget makeCategoriesScreenGenerateRoute();
  // Widget makeProductScreen(Dish dish);
  // Widget makeShoppingCartScreen();
  Widget makeCategoriesScreen();
  Widget makeDishesScreen(({int id, String title}) configuration);
  Widget makeHomeScreen();
}

class AppNavigationImpl implements IAppNavigation {
  final IScreenFactory screenFactory;

  const AppNavigationImpl({required this.screenFactory});

  @override
  Map<String, Widget Function(BuildContext)> get routes => {
        AppNavigationRouteNames.home: (_) => screenFactory.makeHomeScreen(),
      };
  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppNavigationRouteNames.dishes:
        final configuration = settings.arguments as ({int id, String title});
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeDishesScreen(configuration),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeCategoriesScreen(),
        );
    }
  }
}
