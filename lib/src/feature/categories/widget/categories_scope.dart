import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/common/router/app_navigation_route_names.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_state.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_bloc.dart';
import 'package:shop_app_bloc/src/feature/categories/model/category.dart';

abstract class CategoriesScope {
  static void moveToDishes(BuildContext context, {required int index}) {
    final bloc = context.read<CategoriesBloc>();
    final category = bloc.state.categories[index];

    ({int id, String name}) configuration() => (
          id: category.id,
          name: category.name,
        );

    Navigator.of(context).pushNamed(
      AppNavigationRouteNames.dishes,
      arguments: configuration,
    );
  }

  static Category getCategory(BuildContext context, {required int index}) {
    final bloc = context.read<CategoriesBloc>();
    return bloc.state.categories[index];
  }

  static CategoriesState stateOf(BuildContext context) {
    return context.watch<CategoriesBloc>().state;
  }
}
