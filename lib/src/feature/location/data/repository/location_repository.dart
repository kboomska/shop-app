import 'package:shop_app_bloc/src/common/localization/localization_data_provider.dart';
import 'package:shop_app_bloc/src/feature/location/data/api/location_api_client.dart';

abstract interface class ILocationRepository {
  Future<String?> getAddress();
}

final class LocationRepositoryImpl implements ILocationRepository {
  final ILocalizationDataProvider _localizationDataProvider;
  final ILocationApiClient _locationApiClient;

  const LocationRepositoryImpl({
    required ILocalizationDataProvider localizationDataProvider,
    required ILocationApiClient locationApiClient,
  })  : _localizationDataProvider = localizationDataProvider,
        _locationApiClient = locationApiClient;

  @override
  Future<String?> getAddress() async {
    final locale = _localizationDataProvider.locale;
    return await _locationApiClient.getAddress(locale);
  }
}
