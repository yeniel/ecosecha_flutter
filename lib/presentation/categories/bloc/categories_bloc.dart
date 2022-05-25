import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'categories_state.dart';
part 'categories_event.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required Repository repository})
      : _repository = repository,
        super(const CategoriesState()) {
    on<CategoriesRequestedEvent>(_onCategoriesRequestedEvent);
  }

  final Repository _repository;

  void _onCategoriesRequestedEvent(CategoriesRequestedEvent event, Emitter<CategoriesState> emit) {
    var categories = _repository.categories;

    if (categories != null) {
      emit(state.copyWith(categories: categories));
    }
  }
}
