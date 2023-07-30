import 'package:shop_app_bloc/src/feature/categories/data/api/categories_client.dart';
import 'package:shop_app_bloc/src/feature/categories/model/categories_response.dart';

abstract interface class ICategoriesRepository {
  Future<CategoriesResponse> getCategories();
}

class CategoriesRepositoryImpl implements ICategoriesRepository {
  final ICategoriesClient _client;

  const CategoriesRepositoryImpl({
    required ICategoriesClient client,
  }) : _client = client;

  @override
  Future<CategoriesResponse> getCategories() async {
    return _client.getCategories();
  }
}
