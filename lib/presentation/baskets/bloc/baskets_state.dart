part of 'baskets_bloc.dart';

class BasketsState extends Equatable {
  BasketsState({this.products = const [], this.selectedBasket});

  final List<Product> products;
  final Product? selectedBasket;

  BasketsState copyWith({List<Product>? products, Product? selectedBasket}) {
    return BasketsState(products: products ?? [], selectedBasket: selectedBasket);
  }

  @override
  List<Object> get props => [products];
}
