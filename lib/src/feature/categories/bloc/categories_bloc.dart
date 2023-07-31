import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_bloc/src/feature/categories/data/repository/categories_repository.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_event.dart';
import 'package:shop_app_bloc/src/feature/categories/bloc/categories_state.dart';

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
          await onCategoriesEvent$Load(event, emit);
        } else if (event is CategoriesEvent$Reset) {
          await onCategoriesEvent$Reset(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> onCategoriesEvent$Load(
    CategoriesEvent$Load event,
    Emitter<CategoriesState> emit,
  ) async {
    if (state is CategoriesState$Processing) return;

    emit(CategoriesState.processing(categories: state.categories));
    final categoriesResponse = await _categoriesRepository.getCategories();
    final categories = categoriesResponse.categories;
    emit(CategoriesState.idle(categories: categories));
  }

  Future<void> onCategoriesEvent$Reset(
    CategoriesEvent$Reset event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesState.initialState);
  }
}
