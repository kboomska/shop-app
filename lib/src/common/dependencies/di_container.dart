import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/categories/data/api/categories_network_data_provider.dart';
import 'package:shop_app_bloc/src/feature/categories/data/repository/categories_repository.dart';
import 'package:shop_app_bloc/src/feature/location/data/repository/location_repository.dart';
import 'package:shop_app_bloc/src/feature/location/data/api/location_api_client.dart';
import 'package:shop_app_bloc/src/feature/categories/widget/categories_screen.dart';
import 'package:shop_app_bloc/src/common/localization/localization_storage.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_bloc.dart';
import 'package:shop_app_bloc/src/feature/home/widget/home_screen.dart';
import 'package:shop_app_bloc/src/feature/date/cubit/date_cubit.dart';
import 'package:shop_app_bloc/src/common/network/network_client.dart';
import 'package:shop_app_bloc/src/common/router/app_navigation.dart';
import 'package:shop_app_bloc/src/common/network/http_client.dart';
import 'package:shop_app_bloc/src/common/widget/app.dart';
import 'package:shop_app_bloc/main.dart';

IAppFactory makeAppFactory() => AppFactoryImpl();

final class AppFactoryImpl implements IAppFactory {
  final _diContainer = _DIContainer();

  AppFactoryImpl();

  /// Create [App]
  @override
  Widget makeApp() => App(
        navigation: _diContainer._makeAppNavigation(),
      );
}

final class _DIContainer {
  final ILocalizationStorage _localizationStorage = LocalizationStorageImpl();

  _DIContainer();

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
  DateCubit _makeDateCubit() => DateCubit(
        localizationStorage: _localizationStorage,
      );

  /// Create [LocationApiClientImpl]
  ILocationApiClient _makeLocationApiClient() => const LocationApiClientImpl();

  /// Create [LocationRepositoryImpl]
  ILocationRepository _makeLocationRepository() => LocationRepositoryImpl(
        locationApiClient: _makeLocationApiClient(),
      );
}

final class _ScreenFactoryImpl implements IScreenFactory {
  final _DIContainer _diContainer;
  DateCubit? _dateCubit;

  _ScreenFactoryImpl({required _DIContainer diContainer})
      : _diContainer = diContainer;

  DateCubit _dateCubitInstance() {
    final dateCubit = _dateCubit ?? _diContainer._makeDateCubit();
    _dateCubit = dateCubit;
    return dateCubit;
  }

  @override
  Widget makeHomeScreen() {
    return BlocProvider(
      create: (_) => _dateCubitInstance(),
      child: HomeScreen(screenFactory: this),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _diContainer._makeCategoriesBloc(),
        ),
        BlocProvider(
          create: (_) => _dateCubitInstance(),
        ),
      ],
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
