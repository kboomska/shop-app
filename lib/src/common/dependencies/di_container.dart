import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/categories/data/api/categories_network_data_provider.dart';
import 'package:shop_app_bloc/src/feature/categories/data/repository/categories_repository.dart';
import 'package:shop_app_bloc/src/feature/location/data/repository/location_repository.dart';
import 'package:shop_app_bloc/src/feature/dishes/data/api/dishes_network_data_provider.dart';
import 'package:shop_app_bloc/src/feature/dishes/data/repository/dishes_repository.dart';
import 'package:shop_app_bloc/src/feature/location/data/api/geolocator_api_client.dart';
import 'package:shop_app_bloc/src/feature/location/data/api/geocoding_api_client.dart';
import 'package:shop_app_bloc/src/feature/categories/widget/categories_screen.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_bloc.dart';
import 'package:shop_app_bloc/src/feature/location/cubit/location_cubit.dart';
import 'package:shop_app_bloc/src/feature/dishes/widget/dishes_screen.dart';
import 'package:shop_app_bloc/src/feature/dishes/bloc/dishes_bloc.dart';
import 'package:shop_app_bloc/src/feature/home/widget/home_screen.dart';
import 'package:shop_app_bloc/src/feature/date/widget/date_scope.dart';
import 'package:shop_app_bloc/src/common/network/network_client.dart';
import 'package:shop_app_bloc/src/common/router/app_navigation.dart';
import 'package:shop_app_bloc/src/common/network/http_client.dart';
import 'package:shop_app_bloc/src/common/widget/app.dart';
import 'package:shop_app_bloc/main.dart';

IAppFactory makeAppFactory() => const AppFactoryImpl();

final class AppFactoryImpl implements IAppFactory {
  final _diContainer = const _DIContainer();

  const AppFactoryImpl();

  /// Create [App]
  @override
  Widget makeApp() => App(
        navigation: _diContainer._makeAppNavigation(),
      );
}

final class _DIContainer {
  const _DIContainer();

  /// Factories

  /// Create [_ScreenFactoryImpl]
  IScreenFactory _makeScreenFactory() => _ScreenFactoryImpl(diContainer: this);

  /// Navigation

  /// Create [AppNavigationImpl]
  IAppNavigation _makeAppNavigation() => AppNavigationImpl(
        screenFactory: _makeScreenFactory(),
      );

  /// API Clients

  /// Create [HttpClientImpl]
  IHttpClient _httpClient() => const HttpClientImpl();

  /// Create [NetworkClientImpl]
  INetworkClient _makeNetworkClient() => NetworkClientImpl(
        httpClient: _httpClient(),
      );

  /// Create [GeolocatorApiClientImpl]
  IGeolocatorApiClient _makeGeolocatorApiClient() =>
      const GeolocatorApiClientImpl();

  /// Create [GeocodingApiClientImpl]
  IGeocodingApiClient _makeGeocodingApiClient() =>
      const GeocodingApiClientImpl();

  /// Data Providers

  /// Create [CategoriesNetworkDataProviderImpl]
  ICategoriesNetworkDataProvider _makeCategoriesNetworkDataProvider() =>
      CategoriesNetworkDataProviderImpl(
        networkClient: _makeNetworkClient(),
      );

  /// Create [DishesNetworkDataProviderImpl]
  IDishesNetworkDataProvider _makeDishesNetworkDataProvider() =>
      DishesNetworkDataProviderImpl(
        networkClient: _makeNetworkClient(),
      );

  /// Repositories

  /// Create [CategoriesRepositoryImpl]
  ICategoriesRepository _makeCategoriesRepository() => CategoriesRepositoryImpl(
        networkDataProvider: _makeCategoriesNetworkDataProvider(),
      );

  /// Create [DishesRepositoryImpl]
  IDishesRepository _makeDishesRepository() => DishesRepositoryImpl(
        networkDataProvider: _makeDishesNetworkDataProvider(),
      );

  /// Create [LocationRepositoryImpl]
  ILocationRepository _makeLocationRepository() => LocationRepositoryImpl(
        geolocatorApiClient: _makeGeolocatorApiClient(),
        geocodingApiClient: _makeGeocodingApiClient(),
      );

  /// BLoC & Cubit

  /// Create [CategoriesBloc]
  CategoriesBloc _makeCategoriesBloc() => CategoriesBloc(
        categoriesRepository: _makeCategoriesRepository(),
      );

  /// Create [DishesBloc]
  DishesBloc _makeDishesBloc() => DishesBloc(
        dishesRepository: _makeDishesRepository(),
      );

  /// Create [LocationCubit]
  LocationCubit _makeLocationCubit() => LocationCubit(
        locationRepository: _makeLocationRepository(),
      );
}

final class _ScreenFactoryImpl implements IScreenFactory {
  final _DIContainer _diContainer;

  const _ScreenFactoryImpl({required _DIContainer diContainer})
      : _diContainer = diContainer;

  /// Create [HomeScreen]
  @override
  Widget makeHomeScreen() {
    return BlocProvider(
      create: (_) => _diContainer._makeLocationCubit(),
      child: DateScope(
        child: HomeScreen(screenFactory: this),
      ),
    );
  }

  /// Create [CategoriesScreenGenerateRoute]
  @override
  Widget makeCategoriesScreenGenerateRoute() {
    return Navigator(
      onGenerateRoute: _diContainer._makeAppNavigation().onGenerateRoute,
    );
  }

  /// Create [CategoriesScreen]
  @override
  Widget makeCategoriesScreen() {
    return BlocProvider(
      create: (_) => _diContainer._makeCategoriesBloc(),
      child: const CategoriesScreen(),
    );
  }

  /// Create [DishesScreen]
  @override
  Widget makeDishesScreen(({int id, String title}) configuration) {
    return BlocProvider(
      create: (_) => _diContainer._makeDishesBloc(),
      child: DishesScreen(configuration: configuration),
    );
  }

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
