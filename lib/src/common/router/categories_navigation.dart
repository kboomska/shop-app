import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/common/router/app_navigation_route_names.dart';
import 'package:shop_app_bloc/src/feature/home/widget/home_screen.dart';
import 'package:shop_app_bloc/src/common/router/app_navigation.dart';

class CategoriesNavigationImpl implements ICategoriesNavigation {
  final IScreenFactory screenFactory;

  const CategoriesNavigationImpl({required this.screenFactory});

  @override
  Widget categoriesScreenNavigator() {
    return Navigator(
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<Object> _onGenerateRoute(RouteSettings settings) {
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
