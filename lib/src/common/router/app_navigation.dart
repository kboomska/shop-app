import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/common/router/app_navigation_route_names.dart';
import 'package:shop_app_bloc/src/common/widget/app.dart';

abstract interface class IScreenFactory {
  // Widget makeCategoryScreen(CategoryScreenConfiguration configuration);
  // Widget makeMainScreenGenerateRoute();
  // Widget makeProductScreen(Dish dish);
  // Widget makeShoppingCartScreen();
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
  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppNavigationRouteNames.category:
      //   final configuration = settings.arguments as CategoryScreenConfiguration;
      //   return MaterialPageRoute(
      //     builder: (_) => screenFactory.makeCategoryScreen(configuration),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeCategoriesScreen(),
        );
    }
  }
}
