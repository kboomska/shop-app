import 'dart:developer';
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/dishes/data/repository/dishes_repository.dart';
import 'package:shop_app_bloc/src/common/network/network_client_exception.dart';
import 'package:shop_app_bloc/src/feature/dishes/bloc/dishes_event.dart';
import 'package:shop_app_bloc/src/feature/dishes/bloc/dishes_state.dart';
import 'package:shop_app_bloc/src/feature/dishes/model/dish.dart';

class DishesBloc extends Bloc<DishesEvent, DishesState> {
  final ({int id, String title}) _configuration;
  final IDishesRepository _dishesRepository;

  DishesBloc({
    required ({int id, String title}) configuration,
    required IDishesRepository dishesRepository,
    DishesState? initialState,
  })  : _configuration = configuration,
        _dishesRepository = dishesRepository,
        super(initialState ?? DishesState.initialState) {
    on<DishesEvent>(
      (event, emit) async {
        switch (event) {
          case DishesEvent$Load _:
            await _onDishesEvent$Load(event, emit);
          case DishesEvent$Reset _:
            await _onDishesEvent$Reset(event, emit);
        }
        // if (event is DishesEvent$Load) {
        //   await _onDishesEvent$Load(event, emit);
        // } else if (event is DishesEvent$Reset) {
        //   await _onDishesEvent$Reset(event, emit);
        // }
      },
      transformer: sequential(),
    );

    log('Chosen category: ${_configuration.id} - ${_configuration.title}');

    add(DishesEvent$Load());
  }

  String get title => _configuration.title;

  Future<void> _onDishesEvent$Load(
    DishesEvent$Load event,
    Emitter<DishesState> emit,
  ) async {
    if (state is DishesState$Processing) return;

    emit(DishesState.processing(dishes: state.dishes, tags: state.tags));

    String? error;
    List<Dish>? dishes;

    try {
      final categoriesResponse = await _dishesRepository
          .getDishes()
          .timeout(const Duration(seconds: 3));
      dishes = categoriesResponse.dishes;
    } on TimeoutException {
      error =
          'Превышено время ожидания ответа от сервера. Повторите попытку позднее';
    } on NetworkClientException catch (e) {
      switch (e.type) {
        case NetworkClientExceptionType.network:
          error = 'Сервер не доступен. Проверьте подключение к сети интернет';
        case NetworkClientExceptionType.other:
          error = 'Произошла ошибка соединения. Попробуйте еще раз';
      }
    } catch (_) {
      error = 'Произошла ошибка при загрузке данных';
      rethrow;
    } finally {
      emit(DishesState.idle(
        dishes: dishes ?? state.dishes,
        tags: state.tags,
        error: error,
      ));
    }
  }

  Future<void> _onDishesEvent$Reset(
    DishesEvent$Reset event,
    Emitter<DishesState> emit,
  ) async {
    emit(DishesState.initialState);
  }
}
