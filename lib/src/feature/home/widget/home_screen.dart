import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/location/cubit/location_cubit.dart';
import 'package:shop_app_bloc/src/common/router/app_navigation.dart';
import 'package:shop_app_bloc/src/common/resources/resources.dart';
import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final IScreenFactory screenFactory;

  const HomeScreen({super.key, required this.screenFactory});

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
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    context.read<LocationCubit>().getAddress(localeTag);
  }

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      bottomNavigationBar: bottomNavigationBarHandler(
        index: _selectedTab,
        labelList: _bottomNavigationBarOptions,
        onSelectTab: onSelectTab,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          widget.screenFactory.makeCategoriesScreen(),
          Center(
            child: Text(_bottomNavigationBarOptions[1]),
          ),
          Center(
            child: Text(_bottomNavigationBarOptions[2]),
          ),
          // Center(
          //   child: Text(_bottomNavigationBarOptions[3]),
          // ),
          widget.screenFactory.makeCategoriesScreen(),
        ],
      ),
    );
  }
}

Widget bottomNavigationBarHandler({
  required int index,
  required List<String> labelList,
  required Function(int) onSelectTab,
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
