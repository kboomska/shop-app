import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:shop_app_bloc/src/common/router/app_navigation_route_names.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_state.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_bloc.dart';
import 'package:shop_app_bloc/src/feature/categories/model/category.dart';

abstract class CategoriesScope {
  static void onTapCategoryByIndex(BuildContext context, {required int index}) {
    final bloc = context.read<CategoriesBloc>();
    final category = bloc.state.categories[index];

    ({int id, String title}) configuration() => (
          id: category.id,
          title: category.name,
        );

    context.go(
      AppNavigationRoutes.dishes,
      extra: configuration(),
    );
  }

  static Category categoryByIndex(BuildContext context, {required int index}) {
    final bloc = context.read<CategoriesBloc>();
    return bloc.state.categories[index];
  }

  static CategoriesState stateOf(BuildContext context, {bool listen = true}) {
    return listen
        ? context.watch<CategoriesBloc>().state
        : context.read<CategoriesBloc>().state;
  }
}
