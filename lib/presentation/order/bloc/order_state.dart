part of 'order_bloc.dart';

class OrderState extends Equatable {
  OrderState({this.order = Order.empty, this.totalPrice = 0.0, this.confirmed = true, this.minimumAmount = 0});

  final Order order;
  final double totalPrice;
  final bool confirmed;
  final int minimumAmount;

  OrderState copyWith({order, totalPrice, confirmed, minimumAmount}) {
    return OrderState(
      order: order ?? this.order,
      totalPrice: totalPrice ?? this.totalPrice,
      confirmed: confirmed ?? this.confirmed,
      minimumAmount: minimumAmount ?? this.minimumAmount,
    );
  }

  @override
  List<Object> get props => [order, totalPrice, confirmed, minimumAmount];
}
