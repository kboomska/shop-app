import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/categories/bloc/categories_state.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_bloc.dart';
import 'package:shop_app_bloc/src/common/theme/app_typography.dart';
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
      body: const _CategoriesScreenBody(),
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
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: SizedBox(
            height: 24,
            width: 24,
            child: Image.asset(
              AppIcons.location,
              color: AppColors.appBarIcon,
            ),
          ),
        ),
        const SizedBox(width: 4),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Санкт-Петербург',
                overflow: TextOverflow.ellipsis,
                style: AppTypography.headline1,
              ),
              SizedBox(height: 4),
              Text(
                '12 Августа, 2023',
                overflow: TextOverflow.ellipsis,
                style: AppTypography.subhead1,
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

class _CategoriesScreenBody extends StatelessWidget {
  const _CategoriesScreenBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CategoriesBloc>().state;

    return switch (state) {
      CategoriesState$Processing _ => const _CategoriesScreenProcessing(),
      CategoriesState$Idle _ => state.hasError
          ? _CategoriesScreenError(state: state)
          : _CategoryListWidget(state: state),
    };
  }
}

class _CategoriesScreenProcessing extends StatelessWidget {
  const _CategoriesScreenProcessing();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.buttonBackground,
      ),
    );
  }
}

class _CategoriesScreenError extends StatelessWidget {
  final CategoriesState state;

  const _CategoriesScreenError({required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          state.error ?? 'Неизвестная ошибка',
          style: AppTypography.subhead1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _CategoryListWidget extends StatelessWidget {
  final CategoriesState state;

  const _CategoryListWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    final categoryCount = state.categories.length;

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
                    style: AppTypography.headlineCategory,
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
