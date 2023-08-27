import 'package:flutter/material.dart';

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
    // final model = context.read<CategoryScreenViewModel>();
    return const Text(
      // model.title,
      'Категория блюд',
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
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.dishTagBackgroundSelected,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Text(
              'Тэг блюда',
              textAlign: TextAlign.start,
              style: AppTypography.headlineDishTag(
                AppColors.dishTagTextSelected,
              ),
            ),
          ),
        ),
        // child: ListView.separated(
        //   shrinkWrap: true,
        //   itemCount: tags.length,
        //   scrollDirection: Axis.horizontal,
        //   physics: const BouncingScrollPhysics(),
        //   separatorBuilder: (context, index) => const SizedBox(width: 8),
        //   itemBuilder: (context, index) {
        //     return InkWell(
        //       onTap: () => model.onTagTap(index),
        //       child: DecoratedBox(
        //         decoration: BoxDecoration(
        //           color: tags[index].backgroundColor,
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(
        //             horizontal: 16,
        //             vertical: 10,
        //           ),
        //           child: Text(
        //             tags[index].name,
        //             textAlign: TextAlign.start,
        //             style: TextStyle(
        //               color: tags[index].titleColor,
        //               fontWeight: FontWeight.w400,
        //               fontSize: 14,
        //               height: 1.05,
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}

class _DishesGridWidget extends StatelessWidget {
  const _DishesGridWidget();

  @override
  Widget build(BuildContext context) {
    // final dishCount = context.select(
    //   (CategoryScreenViewModel model) => model.dishes.length,
    // );
    var size = MediaQuery.of(context).size;
    final double itemWidth = (size.width / 3) - 16;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20, // dishCount,
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
    // final model = context.read<CategoryScreenViewModel>();
    // final dish = model.dishes[index];

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
                    'https://lh3.googleusercontent.com/fife/APg5EOafwbErJPvjpg_yUmo7-sLRLWZF08C8k6VCCW3lGRyMVGbSnmfUxl1sNzL0oVfwT2cBZDlCMhNi6XBmrMU3zfX_wCbuT3dXN-dVGbl5ccr0NZyKwmee6geavwEEjDPIpAI0TSSoSIW5ESD42sxXblAKnt4vpETfa4MZYRBj6_0FIY9z2iPJHViTigN-vDdCPnq5RgC3f2-HZ1Algs_e5iSbauXwknae6sINa8JiZY9XdGT-qwsXivIrNakp5X4SkYUXTPfm4B9iBBuoO2SlLzDmPU8i6gglA1hNCM6ou2A0OK4x-to0plYfCz3Gpbl3c42iNqyBDi6wgiEKNP5DwyMCwrlQvfCdiXOinp6zXHqGBhV-54nl1bySMOB7oTd-iIIiG9b-P6OkNdpeMXb6INgW2looGoM_LXbEoD9HZ_QsopwtqGF5eDbeNTm4n6D7wiZX4rCpkukKNhS48Ne-cUIPAonEs0LfBEReGhiPBAsieaGqKxCS3ovW93w72qsGehL6hg_Wmxe_LOkwu-UHXyjPbUX8LfMLcL0ZdME2VOSkNnqbnR70TPBk3SJHlH3UOfsEzkxra1voEtM9hVJHgiX8kPm5Ym2V7CPYIXxaAN268ui47S07NUu1vhTOrYcdmn2zmJR8k0l1-zcG1WAx1fgKbnqbtezZ9VfYKRlLAtlsD8h86C4yUhQt74DkbfENrHZmLzVORTlYCi40wlIlAL1UsOzvR26163HYl-ZkRA-71199d3Dxr2T2Nv5IPoJmDuJACqu6FzxT71t_Q3-ZKPzNgt7fGpDf_4Xc9dC7G9lvQKpCMv8d3AVkZjf6czQoETmC7Hf6-9GdAp4jqGGztYRmR7wN11mrucEUzg63Mh5hh5bmbt93SctR_gnlt6rbyqo1aYu0p7xw6z02kyQWspnCPpinOMxLmeOI0TIsaqjq7-2VMWD04vMsYA1uVY3gYaST8IXA62ltb1ngSF6A4Qo3FtBgm1LS2yC-KxywiWSCCWwuv0WOc79dUxMl22XcUt4J_bIB0uyjIOmqD-uPGzger-dP6ZiM8_rBhNz40pJ0gWblxWoc6tpWgbhpTPBCCK7e91t3_pmlbh56EQrsKycQHHfTIVe7clQblWHI-Y9qX12WW5jn8QgmAbeAcjEBiqGLfMpWWdCs97HTZAgNYXhikTBXcqCRayvTvZRK5SiNeDzcxSdpLRyG72H6glEyYBL96KuSB1VuylT1APbBcABbDzEvTyNZWZER_NQwu9X5qDxeLmTwyHr0xq_igNaFxMxYDyYqiaAaIuFwG5yQ9d8fnMVo4QYa1HjoB8vVJrHtd2EJltEKe8KgVxjAVQyaSI7ZWwAzJXt4_3bsIgqKzY8ZLdY-xQHtorLRa_GaCaX-KasXOKJKm7nUNQuX3uJS8BlnS_HqJZoIbjRfHEkC2bXEhT7o2NBwMb4Cr87CBQIDjKsXQs8P6bTDsUH96YC4IOiqCL9kVsl6S2rPXd-WDGjk1p9Eqeq6dNUKZVrhalk_dkbsFO6fvGVK3iI8ARoJYbrCThL8EFEUqY58iAYLjDnmmaJH8fN0Odi-QOCLolKiAXg3idpp_hbkqIsncxcmVXYOOSvm1xpMTxq93rV8w_hDEA4Sxi4EjSiom6m3uTWHo0CBtLPa=w1366-h617',
                    // dish.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'Тестовое блюдо',
                // dish.name,
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
