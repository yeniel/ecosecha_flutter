part of 'baskets_bloc.dart';

class BasketsState extends Equatable {
  const BasketsState({this.products = const []});

  final List<Product> products;

  BasketsState copyWith({required products}) {
    return BasketsState(products: products);
  }

  @override
  List<Object> get props => [products];
}
