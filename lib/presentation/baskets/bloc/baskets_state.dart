part of 'baskets_bloc.dart';

class BasketsState extends Equatable {
  const BasketsState({this.orderProducts = const []});

  final List<OrderProduct> orderProducts;

  BasketsState copyWith({required products}) {
    return BasketsState(orderProducts: products);
  }

  @override
  List<Object> get props => [orderProducts];
}
