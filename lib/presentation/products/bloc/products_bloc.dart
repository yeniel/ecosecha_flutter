import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({ProductCategory? category, required Repository repository})
      : _repository = repository,
        _category = category ?? ProductCategory.empty(),
        super(ProductsState(category: category ?? ProductCategory.empty())) {
    on<ProductsInitEvent>(_onProductsRequested);
  }

  final Repository _repository;
  final ProductCategory _category;

  void _onProductsRequested(ProductsInitEvent event, Emitter<ProductsState> emit) {
    var products = _repository.getProductsOfCategory(_category);

    emit(state.copyWith(products: products));
  }
}
