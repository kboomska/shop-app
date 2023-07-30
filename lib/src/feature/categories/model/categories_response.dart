import 'package:json_annotation/json_annotation.dart';

import 'package:shop_app_bloc/src/feature/categories/model/category.dart';

part 'categories_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CategoriesResponse {
  final List<Category> categories;

  CategoriesResponse({
    required this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}
