import 'package:shop_app_bloc/src/feature/categories/model/categories_response.dart';
import 'package:shop_app_bloc/src/common/constant/configuration.dart';
import 'package:shop_app_bloc/src/common/network/network_client.dart';

abstract interface class ICategoriesNetworkDataProvider {
  Future<CategoriesResponse> getCategories();
}

class CategoriesNetworkDataProviderImpl
    implements ICategoriesNetworkDataProvider {
  final INetworkClient _networkClient;

  const CategoriesNetworkDataProviderImpl({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;

  @override
  Future<CategoriesResponse> getCategories() async {
    CategoriesResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final jsonResponse = CategoriesResponse.fromJson(jsonMap);
      return jsonResponse;
    }

    final result = _networkClient.get(
      Configuration.host,
      Configuration.categoriesUrl,
      parser,
    );

    return result;
  }
}
