part of 'order_bloc.dart';

class OrderState extends Equatable {
  OrderState({
    this.order = Order.empty,
    this.totalAmount = 0.0,
    this.confirmed = true,
    this.minimumAmount = 0,
    this.status = OrderStatus.init,
    this.error = '',
  });

  final Order order;
  final double totalAmount;
  final bool confirmed;
  final int minimumAmount;
  final OrderStatus status;
  final String error;

  OrderState copyWith({order, totalAmount, confirmed, minimumAmount, status, error}) {
    return OrderState(
      order: order ?? this.order,
      totalAmount: totalAmount ?? this.totalAmount,
      confirmed: confirmed ?? this.confirmed,
      minimumAmount: minimumAmount ?? this.minimumAmount,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [order, totalAmount, confirmed, minimumAmount, status, error];
}

enum OrderStatus {
  init,
  loading,
  loaded,
  confirmError,
  orderOutOfDate,
}
