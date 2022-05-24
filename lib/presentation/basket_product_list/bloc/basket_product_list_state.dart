part of 'basket_product_list_bloc.dart';

class BasketProductListState extends Equatable {
  const BasketProductListState({required this.basket, this.products = const []});

  final Product basket;
  final List<BasketProduct> products;

  BasketProductListState copyWith({List<BasketProduct>? products}) {
    return BasketProductListState(basket: basket, products: products ?? []);
  }

  @override
  List<Object> get props => [products];
}

