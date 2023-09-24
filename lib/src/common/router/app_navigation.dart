import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:shop_app_bloc/src/common/router/app_navigation_route_names.dart';
import 'package:shop_app_bloc/src/common/widget/app.dart';

abstract interface class IScreenFactory {
  // Widget makeProductScreen(Dish dish);
  // Widget makeShoppingCartScreen();
  Widget makeDishesScreen(({int id, String title}) configuration);
  Widget makeDummyScreen(String option);
  Widget makeHomeScreen(Widget child);
  Widget makeCategoriesScreen();
}

class AppNavigationImpl implements IAppNavigation {
  final IScreenFactory screenFactory;

  const AppNavigationImpl({required this.screenFactory});

  @override
  RouterConfig<Object> get router => GoRouter(
        initialLocation: AppNavigationRoutes.categories,
        debugLogDiagnostics: true,
        routes: [
          ShellRoute(
            builder: (context, state, child) =>
                screenFactory.makeHomeScreen(child),
            routes: [
              /// Create [CategoriesScreen]
              GoRoute(
                path: AppNavigationRoutes.categories,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    child: screenFactory.makeCategoriesScreen(),
                    transitionsBuilder: (_, __, ___, child) {
                      return child;
                    },
                  );
                },
                routes: [
                  /// Create nested [DishesScreen]
                  GoRoute(
                    path: AppNavigationRoutes.dishesRouteName,
                    builder: (context, state) {
                      final configuration =
                          state.extra as ({int id, String title});
                      return screenFactory.makeDishesScreen(configuration);
                    },
                  ),
                ],
              ),

              /// Create Dummy Search screen
              GoRoute(
                path: AppNavigationRoutes.search,
                pageBuilder: (context, state) {
                  final option = state.extra as String;
                  return CustomTransitionPage(
                    child: screenFactory.makeDummyScreen(option),
                    transitionsBuilder: (_, __, ___, child) {
                      return child;
                    },
                  );
                },
              ),

              /// Create Dummy Shopping Cart screen
              GoRoute(
                path: AppNavigationRoutes.cart,
                pageBuilder: (context, state) {
                  final option = state.extra as String;
                  return CustomTransitionPage(
                    child: screenFactory.makeDummyScreen(option),
                    transitionsBuilder: (_, __, ___, child) {
                      return child;
                    },
                  );
                },
              ),

              /// Create Dummy Profile screen
              GoRoute(
                path: AppNavigationRoutes.profile,
                pageBuilder: (context, state) {
                  final option = state.extra as String;
                  return CustomTransitionPage(
                    child: screenFactory.makeDummyScreen(option),
                    transitionsBuilder: (_, __, ___, child) {
                      return child;
                    },
                  );
                },
              ),
            ],
          ),
        ],
      );
}
