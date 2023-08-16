import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/categories/data/api/categories_network_data_provider.dart';
import 'package:shop_app_bloc/src/feature/categories/data/repository/categories_repository.dart';
import 'package:shop_app_bloc/src/feature/location/data/repository/location_repository.dart';
import 'package:shop_app_bloc/src/feature/location/data/api/geolocator_api_client.dart';
import 'package:shop_app_bloc/src/feature/location/data/api/geocoding_api_client.dart';
import 'package:shop_app_bloc/src/feature/categories/widget/categories_screen.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_bloc.dart';
import 'package:shop_app_bloc/src/feature/location/cubit/location_cubit.dart';
import 'package:shop_app_bloc/src/feature/home/widget/home_screen.dart';
import 'package:shop_app_bloc/src/feature/date/widget/date_scope.dart';
import 'package:shop_app_bloc/src/feature/date/cubit/date_cubit.dart';
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

  /// Create [_ScreenFactoryImpl]
  IScreenFactory _makeScreenFactory() => _ScreenFactoryImpl(diContainer: this);

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

  /// Create [DateCubit]
  // DateCubit _makeDateCubit() => DateCubit();

  /// Create [GeolocatorApiClientImpl]
  IGeolocatorApiClient _makeGeolocatorApiClient() =>
      const GeolocatorApiClientImpl();

  /// Create [GeocodingApiClientImpl]
  IGeocodingApiClient _makeGeocodingApiClient() =>
      const GeocodingApiClientImpl();

  /// Create [LocationRepositoryImpl]
  ILocationRepository _makeLocationRepository() => LocationRepositoryImpl(
        geolocatorApiClient: _makeGeolocatorApiClient(),
        geocodingApiClient: _makeGeocodingApiClient(),
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

  @override
  Widget makeHomeScreen() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _diContainer._makeLocationCubit(),
        ),
        // BlocProvider(
        //   create: (_) => _diContainer._makeDateCubit(),
        // ),
      ],
      child: DateScope(
        child: HomeScreen(screenFactory: this),
      ),
    );
  }

  // @override
  // Widget makeMainScreenGenerateRoute() {
  //   return Navigator(
  //     onGenerateRoute: diContainer._makeShopAppNavigation().onGenerateRoute,
  //   );
  // }

  @override
  Widget makeCategoriesScreen() {
    return BlocProvider(
      create: (_) => _diContainer._makeCategoriesBloc(),
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
