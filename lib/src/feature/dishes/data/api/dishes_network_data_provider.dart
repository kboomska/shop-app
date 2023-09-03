import 'package:shop_app_bloc/src/feature/dishes/model/dishes_response.dart';
import 'package:shop_app_bloc/src/common/constant/configuration.dart';
import 'package:shop_app_bloc/src/common/network/network_client.dart';

abstract interface class IDishesNetworkDataProvider {
  Future<DishesResponse> getDishes();
}

class DishesNetworkDataProviderImpl implements IDishesNetworkDataProvider {
  final INetworkClient _networkClient;

  const DishesNetworkDataProviderImpl({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;

  @override
  Future<DishesResponse> getDishes() async {
    DishesResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final jsonResponse = DishesResponse.fromJson(jsonMap);
      return jsonResponse;
    }

    final result = _networkClient.get(
      Configuration.host,
      Configuration.dishesUrl,
      parser,
    );

    return result;
  }
}
