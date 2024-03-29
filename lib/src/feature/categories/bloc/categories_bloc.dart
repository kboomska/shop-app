import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_client/rest_client.dart';

import 'package:shop_app_bloc/src/feature/categories/data/repository/categories_repository.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_event.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_state.dart';
import 'package:shop_app_bloc/src/feature/categories/model/category.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ICategoriesRepository _categoriesRepository;

  CategoriesBloc({
    required ICategoriesRepository categoriesRepository,
    final CategoriesState? initialState,
  })  : _categoriesRepository = categoriesRepository,
        super(initialState ?? CategoriesState.initialState) {
    on<CategoriesEvent>(
      (event, emit) async {
        if (event is CategoriesEvent$Load) {
          await _onCategoriesEvent$Load(event, emit);
        } else if (event is CategoriesEvent$Reset) {
          await _onCategoriesEvent$Reset(event, emit);
        }
      },
      transformer: sequential(),
    );

    add(CategoriesEvent$Load());
  }

  Future<void> _onCategoriesEvent$Load(
    CategoriesEvent$Load event,
    Emitter<CategoriesState> emit,
  ) async {
    if (state is CategoriesState$Processing) return;

    emit(CategoriesState.processing(categories: state.categories));

    String? error;
    List<Category>? categories;

    try {
      final categoriesResponse = await _categoriesRepository
          .getCategories()
          .timeout(const Duration(seconds: 3));
      categories = categoriesResponse.categories;
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
      emit(CategoriesState.idle(
        categories: categories ?? state.categories,
        error: error,
      ));
    }
  }

  Future<void> _onCategoriesEvent$Reset(
    CategoriesEvent$Reset event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesState.initialState);
  }
}
