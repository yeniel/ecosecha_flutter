part of 'baskets_bloc.dart';

class BasketsState extends Equatable {
  const BasketsState({this.products = const [], this.order = Order.empty});

  final List<Product> products;
  final Order order;

  BasketsState copyWith({required products}) {
    return BasketsState(products: products);
  }

  bool isProductInOrder({product}) {
    return order.products.contains(product);
  }

  @override
  List<Object> get props => [products];
}
