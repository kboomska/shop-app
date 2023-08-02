import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/categories/data/api/categories_network_data_provider.dart';
import 'package:shop_app_bloc/src/feature/categories/data/repository/categories_repository.dart';
import 'package:shop_app_bloc/src/feature/categories/widget/categories_screen.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_bloc.dart';
import 'package:shop_app_bloc/src/common/network/network_client.dart';
import 'package:shop_app_bloc/src/common/router/app_navigation.dart';
import 'package:shop_app_bloc/src/common/network/http_client.dart';
import 'package:shop_app_bloc/src/common/widget/app.dart';
import 'package:shop_app_bloc/main.dart';

IAppFactory makeAppFactory() => const AppFactoryImpl();

final class AppFactoryImpl implements IAppFactory {
  final _diContainer = const DIContainer();

  const AppFactoryImpl();

  /// Create [App]
  @override
  Widget makeApp() => App(
        navigation: _diContainer._makeAppNavigation(),
      );
}

final class DIContainer {
  const DIContainer();

  /// Create [ScreenFactoryImpl]
  IScreenFactory _makeScreenFactory() => ScreenFactoryImpl(this);

  /// Create [AppNavigationImpl]
  IAppNavigation _makeAppNavigation() => AppNavigationImpl(
        screenFactory: _makeScreenFactory(),
      );

  /// Create [HttpClientImpl]
  IHttpClient _httpClient() => const HttpClientImpl();

  /// Create [NetworkClientImpl]
  INetworkClient _makeNetworkClient() => NetworkClientImpl(
        httpClient: _httpClient(),
      );

  /// Create [CategoriesNetworkDataProviderImpl]
  ICategoriesNetworkDataProvider _makeCategoriesNetworkDataProvider() =>
      CategoriesNetworkDataProviderImpl(
        networkClient: _makeNetworkClient(),
      );

  /// Create [CategoriesRepositoryImpl]
  ICategoriesRepository _makeCategoriesRepository() => CategoriesRepositoryImpl(
        networkDataProvider: _makeCategoriesNetworkDataProvider(),
      );

  /// Create [CategoriesBloc]
  CategoriesBloc _makeCategoriesBloc() => CategoriesBloc(
        categoriesRepository: _makeCategoriesRepository(),
      );
}

final class ScreenFactoryImpl implements IScreenFactory {
  final DIContainer diContainer;

  const ScreenFactoryImpl(this.diContainer);

  // @override
  // Widget makeHomeScreen() {
  //   return HomeScreenWidget(screenFactory: this);
  // }

  // @override
  // Widget makeMainScreenGenerateRoute() {
  //   return Navigator(
  //     onGenerateRoute: diContainer._makeShopAppNavigation().onGenerateRoute,
  //   );
  // }

  @override
  Widget makeCategoriesScreen() {
    return BlocProvider(
      create: (_) => diContainer._makeCategoriesBloc(),
      child: const CategoriesScreen(),
    );
  }

  // @override
  // Widget makeCategoryScreen(CategoryScreenConfiguration configuration) {
  //   return ChangeNotifierProvider(
  //     create: (context) => diContainer._makeCategoryScreenViewModel(
  //       configuration,
  //     ),
  //     child: const CategoryScreenWidget(),
  //   );
  // }

  // @override
  // Widget makeProductScreen(Dish dish) {
  //   return Provider(
  //     create: (context) => diContainer._makeProductScreenViewModel(dish),
  //     child: const ProductScreenWidget(),
  //   );
  // }

  // @override
  // Widget makeShoppingCartScreen() {
  //   return ChangeNotifierProvider(
  //     create: (context) => diContainer._makeShoppingCartScreenViewModel(),
  //     child: const ShoppingCartScreenWidget(),
  //   );
  // }
}
