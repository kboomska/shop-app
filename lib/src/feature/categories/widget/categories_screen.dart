import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/categories/bloc/categories_bloc.dart';
import 'package:shop_app_bloc/src/common/resources/resources.dart';
import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final locale = Localizations.localeOf(context);
  //   Future.microtask(
  //     () => context.read<MainScreenCubit>().setup(locale),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _CategoriesScreenTitle(),
        actions: const [_CategoriesScreenProfile()],
        elevation: 0,
      ),
      backgroundColor: AppColors.appBackground,
      body: const _CategoryListWidget(),
    );
  }
}

class _CategoriesScreenTitle extends StatelessWidget {
  const _CategoriesScreenTitle();

  @override
  Widget build(BuildContext context) {
    // final date = context.select(
    //   (MainScreenCubit cubit) => cubit.state.date,
    // );
    // final location = context.select(
    //   (MainScreenCubit cubit) => cubit.state.location,
    // );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Image.asset(
            AppIcons.location,
            color: AppColors.appBarIcon,
          ),
        ),
        const SizedBox(width: 4),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22,
                child: FittedBox(
                  child: Text(
                    'Санкт-Петербург',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.textHeadline,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                '12 Августа, 2023',
                style: TextStyle(
                  color: AppColors.textSubhead,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoriesScreenProfile extends StatelessWidget {
  const _CategoriesScreenProfile();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CircleAvatar(
        radius: 22,
        foregroundImage: AssetImage(AppImages.profileAvatar),
      ),
    );
  }
}

class _CategoryListWidget extends StatelessWidget {
  const _CategoryListWidget();

  @override
  Widget build(BuildContext context) {
    final categoryCount = context.select(
      (CategoriesBloc bloc) => bloc.state.categories.length,
    );

    return ListView.builder(
      itemCount: categoryCount,
      itemBuilder: (context, index) => _CategoryItemWidget(index: index),
    );
  }
}

class _CategoryItemWidget extends StatelessWidget {
  final int index;

  const _CategoryItemWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CategoriesBloc>();
    final category = bloc.state.categories[index];

    // void onCategoryTap(context) {
    //   final configuration = CategoryScreenConfiguration(
    //     id: category.id,
    //     name: category.name,
    //   );

    //   Navigator.of(context).pushNamed(
    //     MainNavigationRouteNames.category,
    //     arguments: configuration,
    //   );
    // }

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          // onTap: () => onCategoryTap(context),
          child: Stack(
            children: [
              Image.network(category.imageUrl),
              Positioned(
                top: 12,
                left: 16,
                child: ConstrainedBox(
                  constraints: BoxConstraints.loose(
                    const Size.fromWidth(191),
                  ),
                  child: Text(
                    category.name,
                    style: const TextStyle(
                      color: AppColors.textHeadline,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      height: 1.25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
