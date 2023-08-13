import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/location/data/api/location_api_client_exception.dart';
import 'package:shop_app_bloc/src/feature/location/data/repository/location_repository.dart';
import 'package:shop_app_bloc/src/common/localization/localization_storage.dart';
import 'package:shop_app_bloc/src/feature/location/cubit/location_state.dart';

final class LocationCubit extends Cubit<LocationState> {
  final ILocalizationStorage _localizationStorage;
  final ILocationRepository _locationRepository;

  LocationCubit({
    required ILocalizationStorage localizationStorage,
    required ILocationRepository locationRepository,
    LocationState? initialState,
  })  : _localizationStorage = localizationStorage,
        _locationRepository = locationRepository,
        super(initialState ?? LocationState.initialState);

  Future<void> getAddress() async {
    if (state is LocationState$Processing) return;

    emit(LocationState.processing(location: state.location));

    String? location;
    final locale = _localizationStorage.locale;

    try {
      location = await _locationRepository.getAddress(locale);
    } on LocationApiClientException catch (e) {
      switch (e.type) {
        case LocationApiClientExceptionType.permission:
          location = 'Геолокация не доступна';
          break;
        case LocationApiClientExceptionType.services:
          location = 'Сервисы геолокации отключены';
          break;
        case LocationApiClientExceptionType.other:
          location = 'Не удалось установить местоположение';
          break;
      }
    } catch (_) {
      location = 'Неизвестная ошибка, повторите попытку';
    } finally {
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(LocationState.idle(location: location ?? state.location));
    }
  }
}
