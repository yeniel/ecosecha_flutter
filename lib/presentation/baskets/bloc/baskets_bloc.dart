import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'baskets_event.dart';

part 'baskets_state.dart';

class BasketsBloc extends Bloc<BasketsEvent, BasketsState> {
  BasketsBloc({required Repository repository})
      : _repository = repository,
        super(BasketsState()) {
    on<BasketsRequestedEvent>(_onBasketsRequested);
    on<BasketTapEvent>(_onBasketTapped);
    on<BackToBasketsEvent>(_onBackToBaskets);
  }

  final Repository _repository;

  void _onBasketsRequested(BasketsRequestedEvent event, Emitter<BasketsState> emit) {
    var baskets = _repository.baskets;

    emit(state.copyWith(products: baskets));
  }

  void _onBasketTapped(BasketTapEvent event, Emitter<BasketsState> emit) {
    var basketProducts = _repository.getProductsOfBasket(event.basket);

    emit(state.copyWith(products: basketProducts));
  }

  void _onBackToBaskets(BackToBasketsEvent event, Emitter<BasketsState> emit) {
    var baskets = _repository.baskets;

    emit(state.copyWith(selectedBasket: null, products: baskets));
  }
}
