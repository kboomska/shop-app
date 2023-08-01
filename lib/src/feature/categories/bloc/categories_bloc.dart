import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/categories/data/repository/categories_repository.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_event.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_state.dart';
import 'package:shop_app_bloc/src/common/network/network_client_exception.dart';
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
    } on NetworkClientException catch (e) {
      switch (e.type) {
        case NetworkClientExceptionType.network:
          error = 'Сервер не доступен. Проверьте подключение к сети интернет';
        case NetworkClientExceptionType.other:
          error = 'Произошла ошибка. Попробуйте еще раз';
      }
    } catch (_) {
      error = 'Неизвестная ошибка, повторите попытку';
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
