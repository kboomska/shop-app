import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/dishes/bloc/dishes_bloc.dart';
import 'package:shop_app_bloc/src/common/theme/app_typography.dart';
import 'package:shop_app_bloc/src/common/resources/resources.dart';
import 'package:shop_app_bloc/src/common/theme/app_colors.dart';

class DishesScreen extends StatefulWidget {
  const DishesScreen({super.key});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   context.read<CategoryScreenViewModel>().setDishTag();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const _DishesScreenTitle(),
        actions: const [_DishesScreenProfile()],
        iconTheme: const IconThemeData(color: AppColors.appBarIcon),
        elevation: 0,
      ),
      backgroundColor: AppColors.appBackground,
      body: ListView(
        children: const [
          _DishFilter(),
          _DishesGridWidget(),
        ],
      ),
    );
  }
}

class _DishesScreenTitle extends StatelessWidget {
  const _DishesScreenTitle();

  @override
  Widget build(BuildContext context) {
    final title = context.read<DishesBloc>().title;

    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.headline1,
    );
  }
}

class _DishesScreenProfile extends StatelessWidget {
  const _DishesScreenProfile();

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

class _DishFilter extends StatelessWidget {
  const _DishFilter();

  @override
  Widget build(BuildContext context) {
    // final model = context.read<CategoryScreenViewModel>();
    // final tags = context.select((CategoryScreenViewModel model) => model.tags);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: SizedBox(
        height: 35,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 4, //tags.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return InkWell(
              // onTap: () => model.onTagTap(index),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors
                      .dishTagBackgroundSelected, // tags[index].backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Text(
                    'Тэг блюда', // tags[index].name,
                    textAlign: TextAlign.start,
                    style: AppTypography.headlineDishTag(
                      AppColors.dishTagTextSelected, // tags[index].titleColor,
                    ),
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

class _DishesGridWidget extends StatelessWidget {
  const _DishesGridWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DishesBloc>().state;
    final dishCount = state.dishes.length;
    final size = MediaQuery.of(context).size;
    final double itemWidth = (size.width / 3) - 16;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dishCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 14,
        mainAxisExtent: itemWidth + 40,
      ),
      padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
      itemBuilder: (context, index) => _DishItemWidget(
        index: index,
        itemWidth: itemWidth,
      ),
    );
  }
}

class _DishItemWidget extends StatelessWidget {
  final double itemWidth;
  final int index;

  const _DishItemWidget({required this.index, required this.itemWidth});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DishesBloc>();
    final dish = bloc.state.dishes[index];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        // onTap: () => model.onDishTap(context, index),
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
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    dish.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                dish.name,
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
