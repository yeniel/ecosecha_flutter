part of 'basket_product_list_bloc.dart';

abstract class BasketProductListEvent extends Equatable {
  const BasketProductListEvent();
}

class BasketProductListRequestedEvent extends BasketProductListEvent {
  const BasketProductListRequestedEvent();

  @override
  List<Object?> get props => [];
}
