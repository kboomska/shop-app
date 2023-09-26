import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/location/cubit/location_cubit.dart';
import 'package:shop_app_bloc/src/common/resources/resources.dart';
import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

abstract interface class IHomeNestedNavigation {
  Widget dummyScreenNavigator(String name);
  Widget categoriesScreenNavigator();
}

class HomeScreen extends StatefulWidget {
  final IHomeNestedNavigation navigation;

  const HomeScreen({
    required this.navigation,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

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

  void _onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBarHandler(
        index: _selectedTab,
        labelList: _bottomNavigationBarOptions,
        onSelectTab: _onSelectTab,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          widget.navigation.categoriesScreenNavigator(),
          widget.navigation.dummyScreenNavigator(
            _bottomNavigationBarOptions[1],
          ),
          widget.navigation.dummyScreenNavigator(
            _bottomNavigationBarOptions[2],
          ),
          widget.navigation.dummyScreenNavigator(
            _bottomNavigationBarOptions[3],
          ),
        ],
      ),
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
