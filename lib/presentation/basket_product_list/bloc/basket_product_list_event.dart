part of 'basket_product_list_bloc.dart';

abstract class BasketProductListEvent extends Equatable {
  const BasketProductListEvent();
}

class BasketProductListInitEvent extends BasketProductListEvent {
  const BasketProductListInitEvent();

  @override
  List<Object?> get props => [];
}
