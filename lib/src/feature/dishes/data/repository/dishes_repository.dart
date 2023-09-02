import 'package:shop_app_bloc/src/feature/dishes/data/api/dishes_network_data_provider.dart';
import 'package:shop_app_bloc/src/feature/dishes/model/dishes_response.dart';

abstract interface class IDishesRepository {
  Future<DishesResponse> getDishes();
}

class DishesRepositoryImpl implements IDishesRepository {
  final IDishesNetworkDataProvider _networkDataProvider;

  const DishesRepositoryImpl({
    required IDishesNetworkDataProvider networkDataProvider,
  }) : _networkDataProvider = networkDataProvider;

  @override
  Future<DishesResponse> getDishes() async {
    return _networkDataProvider.getDishes();
  }
}
