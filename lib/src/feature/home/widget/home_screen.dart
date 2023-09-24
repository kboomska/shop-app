import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:shop_app_bloc/src/common/router/app_navigation_route_names.dart';
import 'package:shop_app_bloc/src/feature/location/cubit/location_cubit.dart';
import 'package:shop_app_bloc/src/common/resources/resources.dart';
import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

abstract interface class ICategoriesNavigation {
  Widget categoriesScreenNavigator();
}

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<String> _bottomNavigationBarOptions = [
    'Главная',
    'Поиск',
    'Корзина',
    'Аккаунт',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<LocationCubit>().getAddress(makeLocaleIdentifier(locale));
  }

  String makeLocaleIdentifier(Locale locale) {
    return '${locale.languageCode}_${locale.countryCode}';
  }

  int _selectedTab(BuildContext context) {
    final String route = GoRouterState.of(context).uri.toString();
    if (route.startsWith(AppNavigationRoutes.categories)) {
      return 0;
    }
    if (route.startsWith(AppNavigationRoutes.search)) {
      return 1;
    }
    if (route.startsWith(AppNavigationRoutes.cart)) {
      return 2;
    }
    if (route.startsWith(AppNavigationRoutes.profile)) {
      return 3;
    }
    return 0;
  }

  void _onSelectTab(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppNavigationRoutes.categories);
      case 1:
        context.go(
          AppNavigationRoutes.search,
          extra: _bottomNavigationBarOptions[1],
        );
      case 2:
        context.go(
          AppNavigationRoutes.cart,
          extra: _bottomNavigationBarOptions[2],
        );
      case 3:
        context.go(
          AppNavigationRoutes.profile,
          extra: _bottomNavigationBarOptions[3],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      bottomNavigationBar: bottomNavigationBarHandler(
        index: _selectedTab(context),
        labelList: _bottomNavigationBarOptions,
        onSelectTab: (index) => _onSelectTab(index, context),
      ),
      body: widget.child,
    );
  }
}

Widget bottomNavigationBarHandler({
  required int index,
  required List<String> labelList,
  required void Function(int) onSelectTab,
}) {
  return Container(
    height: 69,
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(
          color: AppColors.bottomNavigationBarBorder,
          width: 1,
        ),
      ),
    ),
    child: BottomNavigationBar(
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      iconSize: 24,
      elevation: 0,
      items: [
        makeItem(
          assetImage: AppIcons.home,
          label: labelList[0],
        ),
        makeItem(
          assetImage: AppIcons.search,
          label: labelList[1],
        ),
        makeItem(
          assetImage: AppIcons.cart,
          label: labelList[2],
        ),
        makeItem(
          assetImage: AppIcons.profile,
          label: labelList[3],
        ),
      ],
      onTap: onSelectTab,
    ),
  );
}

BottomNavigationBarItem makeItem({
  required String assetImage,
  required String label,
}) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          assetImage,
          color: AppColors.bottomNavigationBarUnselected,
        ),
      ),
    ),
    activeIcon: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          assetImage,
          color: AppColors.bottomNavigationBarSelected,
        ),
      ),
    ),
    label: label,
  );
}
