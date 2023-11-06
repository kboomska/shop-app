import 'package:rest_client/rest_client.dart';

import 'package:shop_app_bloc/src/feature/dishes/model/dishes_response.dart';
import 'package:shop_app_bloc/src/common/constant/configuration.dart';

abstract interface class IDishesNetworkDataProvider {
  Future<DishesResponse> getDishes();
}

class DishesNetworkDataProviderImpl implements IDishesNetworkDataProvider {
  final IRestClient _restClient;

  const DishesNetworkDataProviderImpl({
    required IRestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<DishesResponse> getDishes() async {
    final result = await _restClient.get(
      Configuration.host,
      Configuration.dishesUrl,
    );

    return DishesResponse.fromJson(result);
  }
}
