part of 'order_bloc.dart';

class OrderState extends Equatable {
  OrderState({this.order = Order.empty, this.totalPrice = 0.0, this.confirmed = true});

  final Order order;
  final double totalPrice;
  final bool confirmed;

  OrderState copyWith({order, totalPrice, confirmed}) {
    return OrderState(
      order: order ?? this.order,
      totalPrice: totalPrice ?? this.totalPrice,
      confirmed: confirmed ?? this.confirmed,
    );
  }

  @override
  List<Object> get props => [order, totalPrice];
}
