part of 'order_bloc.dart';

class OrderState extends Equatable {
  OrderState({this.order = Order.empty, this.totalAmount = 0.0, this.confirmed = true, this.minimumAmount = 0});

  final Order order;
  final double totalAmount;
  final bool confirmed;
  final int minimumAmount;

  OrderState copyWith({order, totalAmount, confirmed, minimumAmount}) {
    return OrderState(
      order: order ?? this.order,
      totalAmount: totalAmount ?? this.totalAmount,
      confirmed: confirmed ?? this.confirmed,
      minimumAmount: minimumAmount ?? this.minimumAmount,
    );
  }

  @override
  List<Object> get props => [order, totalAmount, confirmed, minimumAmount];
}
