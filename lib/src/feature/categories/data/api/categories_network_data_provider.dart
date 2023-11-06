import 'package:rest_client/rest_client.dart';

import 'package:shop_app_bloc/src/feature/categories/model/categories_response.dart';
import 'package:shop_app_bloc/src/common/constant/configuration.dart';

abstract interface class ICategoriesNetworkDataProvider {
  Future<CategoriesResponse> getCategories();
}

class CategoriesNetworkDataProviderImpl
    implements ICategoriesNetworkDataProvider {
  final IRestClient _restClient;

  const CategoriesNetworkDataProviderImpl({
    required IRestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<CategoriesResponse> getCategories() async {
    final result = await _restClient.get(
      Configuration.host,
      Configuration.categoriesUrl,
    );

    return CategoriesResponse.fromJson(result);
  }
}
