part of 'order_bloc.dart';

class OrderState extends Equatable {
  OrderState({this.order = Order.empty, this.totalPrice = 0.0});

  final Order order;
  final double totalPrice;

  OrderState copyWith({Order? order, double? totalPrice}) {
    return OrderState(order: order ?? Order.empty, totalPrice: totalPrice ?? 0.0);
  }

  @override
  List<Object> get props => [order, totalPrice];
}
