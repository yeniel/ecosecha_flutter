import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({ProductCategory? category, required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        _category = category ?? ProductCategory.empty(),
        super(ProductsState(category: category ?? ProductCategory.empty())) {
    on<ProductsInitEvent>(_onProductsInit);
  }

  final ProductsRepository _productsRepository;
  final ProductCategory _category;

  void _onProductsInit(ProductsInitEvent event, Emitter<ProductsState> emit) {
    var products = _productsRepository.getProductsOfCategory(_category);

    emit(state.copyWith(products: products));
  }
}
