import 'dart:developer';
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_client/rest_client.dart';

import 'package:shop_app_bloc/src/feature/dishes/data/repository/dishes_repository.dart';
import 'package:shop_app_bloc/src/feature/dishes/bloc/dishes_event.dart';
import 'package:shop_app_bloc/src/feature/dishes/bloc/dishes_state.dart';
import 'package:shop_app_bloc/src/feature/dishes/model/dish_tag.dart';
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
          case DishesEvent$OnTapTag _:
            await _onDishesEvent$OnTapTag(event, emit);
        }
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
      final dishesResponse = await _dishesRepository
          .getDishes()
          .timeout(const Duration(seconds: 3));

      dishes = dishesResponse.dishes;
    } on TimeoutException {
      error =
          'Превышено время ожидания ответа от сервера. Повторите попытку позднее';
    } on NetworkException catch (e) {
      switch (e) {
        case InternalServerException _:
          error = 'Сервер не доступен. Проверьте подключение к сети интернет';
        case RestClientException _:
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

  Future<void> _onDishesEvent$OnTapTag(
    DishesEvent$OnTapTag event,
    Emitter<DishesState> emit,
  ) async {
    if (state is DishesState$Processing) return;

    final index = event.index;
    final currentIndex = state.tags.indexWhere((tag) => tag.isSelected == true);

    if (index == currentIndex) return;

    final List<DishTag> tags = [...state.tags];

    for (int i = 0; i < tags.length; i++) {
      tags[i] = tags[i].copyWith(isSelected: i == index);
    }

    log('Chosen tag: ${tags[index].name}');

    emit(DishesState.idle(
      dishes: state.dishes,
      tags: tags,
    ));
  }

  Future<void> _onDishesEvent$Reset(
    DishesEvent$Reset event,
    Emitter<DishesState> emit,
  ) async {
    emit(DishesState.initialState);
  }
}
