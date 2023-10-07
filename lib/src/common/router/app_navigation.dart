import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/common/router/app_navigation_route_names.dart';
import 'package:shop_app_bloc/src/common/widget/app.dart';

abstract interface class IScreenFactory {
  // Widget makeProductScreen(Dish dish);
  // Widget makeShoppingCartScreen();
  Widget makeDishesScreen(({int id, String title}) configuration);
  Widget makeDummyScreen(String name);
  Widget makeCategoriesScreen();
  Widget makeHomeScreen();
}

class AppNavigationImpl implements IAppNavigation {
  final IScreenFactory screenFactory;

  const AppNavigationImpl({required this.screenFactory});

  @override
  Map<String, Widget Function(BuildContext)> get routes => {
        AppNavigationRouteNames.home: (_) => screenFactory.makeHomeScreen(),
      };
}
