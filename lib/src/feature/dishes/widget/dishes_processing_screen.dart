import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/dishes/bloc/dishes_bloc.dart';
import 'package:shop_app_bloc/src/common/theme/app_typography.dart';
import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

class DishesScreenProcessing extends StatelessWidget {
  const DishesScreenProcessing({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _DishFilterMockWidget(),
        _DishesGridMockWidget(),
      ],
    );
  }
}

class _DishFilterMockWidget extends StatelessWidget {
  const _DishFilterMockWidget();

  @override
  Widget build(BuildContext context) {
    final tags = context.read<DishesBloc>().state.tags;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: SizedBox(
        height: 35,
        child: ListView.separated(
          itemCount: tags.length,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: tags[index].backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Text(
                  tags[index].name,
                  textAlign: TextAlign.start,
                  style: AppTypography.headlineDishTag(
                    tags[index].titleColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DishesGridMockWidget extends StatelessWidget {
  const _DishesGridMockWidget();

  @override
  Widget build(BuildContext context) {
    const dishCount = 12;
    final size = MediaQuery.of(context).size;
    final double itemWidth = (size.width / 3) - 16;

    return GridView.builder(
      shrinkWrap: true,
      itemCount: dishCount,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 14,
        mainAxisExtent: itemWidth + 40,
      ),
      itemBuilder: (context, index) => _DishItemMockWidget(
        itemWidth: itemWidth,
      ),
    );
  }
}

class _DishItemMockWidget extends StatelessWidget {
  final double itemWidth;

  const _DishItemMockWidget({required this.itemWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: itemWidth,
              width: itemWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.dishItemBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Загрузка...',
                      style: AppTypography.subhead1,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                '',
                textAlign: TextAlign.start,
                style: AppTypography.headlineDishItem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
