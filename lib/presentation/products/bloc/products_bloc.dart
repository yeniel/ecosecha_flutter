import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required Repository repository}) : _repository = repository,
        super(ProductsState()) {
    on<ProductsRequestedEvent>(_onProductsRequested);
    on<CategorySelectedEvent>(_onCategorySelected);
    on<BackToCategoriesEvent>(_onBackToCategories);
  }

  final Repository _repository;

  void _onProductsRequested(ProductsRequestedEvent event, Emitter<ProductsState> emit) {
    var categoryMenu = _repository.categoryMenu;

    if (categoryMenu != null) {
      emit(state.copyWith(categories: categoryMenu));
    }
  }

  void _onCategorySelected(CategorySelectedEvent event, Emitter<ProductsState> emit) {
    var products = _repository.getProductsOfCategory(event.selectedCategory);

    emit(state.copyWith(selectedCategory: event.selectedCategory, products: products));
  }

  void _onBackToCategories(BackToCategoriesEvent event, Emitter<ProductsState> emit) {
    emit(state.copyWith(selectedCategory: null, products: []));
  }
}
