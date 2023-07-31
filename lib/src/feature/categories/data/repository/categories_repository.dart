import 'package:shop_app_bloc/src/feature/categories/data/api/categories_network_data_provider.dart';
import 'package:shop_app_bloc/src/feature/categories/model/categories_response.dart';

abstract interface class ICategoriesRepository {
  Future<CategoriesResponse> getCategories();
}

class CategoriesRepositoryImpl implements ICategoriesRepository {
  final ICategoriesNetworkDataProvider _networkDataProvider;

  const CategoriesRepositoryImpl({
    required ICategoriesNetworkDataProvider networkDataProvider,
  }) : _networkDataProvider = networkDataProvider;

  @override
  Future<CategoriesResponse> getCategories() async {
    return _networkDataProvider.getCategories();
  }
}
