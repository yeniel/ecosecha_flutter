import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'basket_product_list_event.dart';

part 'basket_product_list_state.dart';

class BasketProductListBloc extends Bloc<BasketProductListEvent, BasketProductListState> {
  BasketProductListBloc({Product? basket, required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        _basket = basket ?? Product.empty(),
        super(BasketProductListState(basket: basket ?? Product.empty())) {
    on<BasketProductListInitEvent>(_onBasketProductListInit);
  }

  final Product _basket;
  final ProductsRepository _productsRepository;

  void _onBasketProductListInit(BasketProductListInitEvent event, Emitter<BasketProductListState> emit) {
    var products = _productsRepository.getProductsOfBasket(_basket);

    emit(state.copyWith(products: products));
  }
}
