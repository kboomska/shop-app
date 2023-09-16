import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/location/data/api/geolocator_api_client_exception.dart';
import 'package:shop_app_bloc/src/feature/location/data/repository/location_repository.dart';
import 'package:shop_app_bloc/src/feature/location/cubit/location_state.dart';

final class LocationCubit extends Cubit<LocationState> {
  final ILocationRepository _locationRepository;

  LocationCubit({
    required ILocationRepository locationRepository,
    LocationState? initialState,
  })  : _locationRepository = locationRepository,
        super(initialState ?? LocationState.initialState);

  Future<void> getAddress(String localeTag) async {
    if (state is LocationState$Processing) return;
    if (localeTag == state.localeTag) return;

    emit(LocationState.processing(
      location: 'Определяем местоположение...',
      localeTag: localeTag,
    ));

    String? location;

    try {
      location = await _locationRepository
          .getAddress(localeTag)
          .timeout(const Duration(seconds: 15));
    } on TimeoutException {
      location = 'Превышено время ожидания';
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
      await Future<void>.delayed(const Duration(milliseconds: 1000));

      location ??= 'Не удалось Вас найти';
      emit(LocationState.idle(
        location: location,
        localeTag: state.localeTag,
      ));
    }
  }
}
