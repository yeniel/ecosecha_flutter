import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'basket_product_list_event.dart';

part 'basket_product_list_state.dart';

class BasketProductListBloc extends Bloc<BasketProductListEvent, BasketProductListState> {
  BasketProductListBloc({Product? basket, required Repository repository})
      : _repository = repository,
        _basket = basket ?? Product.empty(),
        super(BasketProductListState(basket: basket ?? Product.empty())) {
    on<BasketProductListRequestedEvent>(_onBasketProductListRequested);
  }

  final Product _basket;
  final Repository _repository;

  void _onBasketProductListRequested(BasketProductListRequestedEvent event, Emitter<BasketProductListState> emit) {
    var products = _repository.getProductsOfBasket(_basket);

    emit(state.copyWith(products: products));
  }
}
