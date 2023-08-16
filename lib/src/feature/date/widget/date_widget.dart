import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/feature/date/widget/date_scope.dart';
import 'package:shop_app_bloc/src/common/theme/app_typography.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateScope.dateOf(context);

    return Text(
      date,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.subhead1,
    );
  }
}
