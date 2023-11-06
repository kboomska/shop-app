import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_client/rest_client.dart';

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
import 'package:shop_app_bloc/src/common/router/app_navigation.dart';
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

  /// Create [RestClientImpl]
  IRestClient _makeRestClient() => RestClientImpl(client: _httpClient());

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
        restClient: _makeRestClient(),
      );

  /// Create [DishesNetworkDataProviderImpl]
  IDishesNetworkDataProvider _makeDishesNetworkDataProvider() =>
      DishesNetworkDataProviderImpl(
        restClient: _makeRestClient(),
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
  DishesBloc _makeDishesBloc(({int id, String title}) configuration) =>
      DishesBloc(
        dishesRepository: _makeDishesRepository(),
        configuration: configuration,
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
  Widget makeHomeScreen(Widget child) {
    return BlocProvider(
      create: (_) => _diContainer._makeLocationCubit(),
      child: DateScope(
        child: HomeScreen(
          child: child,
        ),
      ),
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
      create: (_) => _diContainer._makeDishesBloc(configuration),
      child: const DishesScreen(),
    );
  }

  /// Create Dummy screen
  @override
  Widget makeDummyScreen(String option) {
    return Center(
      child: Text(option),
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
