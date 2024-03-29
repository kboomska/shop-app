import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/feature/categories/widget/categories_scope.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_state.dart';
import 'package:shop_app_bloc/src/feature/location/widget/location_widget.dart';
import 'package:shop_app_bloc/src/feature/date/widget/date_widget.dart';
import 'package:shop_app_bloc/src/common/theme/app_typography.dart';
import 'package:shop_app_bloc/src/common/resources/resources.dart';
import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
              LocationWidget(),
              SizedBox(height: 4),
              DateWidget(),
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
    final state = CategoriesScope.stateOf(context);

    return switch (state) {
      CategoriesState$Processing _ => const _CategoriesScreenProcessing(),
      CategoriesState$Idle _ => state.hasError
          ? _CategoriesScreenError(error: state.error)
          : _CategoryListWidget(categoryCount: state.categories.length),
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
  final String error;

  const _CategoriesScreenError({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          error,
          style: AppTypography.subhead1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _CategoryListWidget extends StatelessWidget {
  final int categoryCount;

  const _CategoryListWidget({required this.categoryCount});

  @override
  Widget build(BuildContext context) {
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
    final category = CategoriesScope.categoryByIndex(context, index: index);

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
          onTap: () =>
              CategoriesScope.onTapCategoryByIndex(context, index: index),
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
