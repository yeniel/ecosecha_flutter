part of 'order_bloc.dart';

class OrderState extends Equatable {
  OrderState({this.order = Order.empty});

  final Order order;

  OrderState copyWith({Order? order}) {
    return OrderState(order: order ?? Order.empty);
  }

  @override
  List<Object> get props => [order];
}
