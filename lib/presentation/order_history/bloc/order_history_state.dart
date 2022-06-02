part of 'order_history_bloc.dart';

class OrderHistoryState extends Equatable {
  const OrderHistoryState({this.orders = const []});

  final List<Order> orders;

  OrderHistoryState copyWith({required List<Order> orders}) {
    return OrderHistoryState(orders: orders);
  }

  @override
  List<Object> get props => [orders];
}
