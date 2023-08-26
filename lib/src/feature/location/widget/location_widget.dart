import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/location/cubit/location_cubit.dart';
import 'package:shop_app_bloc/src/common/theme/app_typography.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final location = context.select(
      (LocationCubit cubit) => cubit.state.location,
    );

    return SizedBox(
      height: 22,
      child: FittedBox(
        child: Text(
          location,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.headline1,
        ),
      ),
    );
  }
}
