import 'package:shop_app_bloc/src/feature/categories/data/api/categories_client.dart';

abstract interface class ICategoriesRepository {}

class CategoriesRepositoryImpl implements ICategoriesRepository {
  final ICategoriesClient _client;

  const CategoriesRepositoryImpl({
    required ICategoriesClient client,
  }) : _client = client;
}
