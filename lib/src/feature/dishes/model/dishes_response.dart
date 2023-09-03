import 'package:json_annotation/json_annotation.dart';

import 'package:shop_app_bloc/src/feature/dishes/model/dish.dart';

part 'dishes_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DishesResponse {
  final List<Dish> dishes;

  DishesResponse({
    required this.dishes,
  });

  factory DishesResponse.fromJson(Map<String, dynamic> json) =>
      _$DishesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DishesResponseToJson(this);
}
