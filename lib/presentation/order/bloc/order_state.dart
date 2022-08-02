part of 'order_bloc.dart';

class OrderState extends Equatable {
  OrderState({
    this.order = Order.empty,
    this.totalAmount = 0.0,
    this.pageStatus = OrderPageStatus.init,
    this.canConfirm = true,
    this.canCancel = true,
    this.minimumAmount = 0,
    this.error = '',
  });

  final Order order;
  final double totalAmount;
  final OrderPageStatus pageStatus;
  final bool canConfirm;
  final bool canCancel;
  final int minimumAmount;
  final String error;

  OrderState copyWith({order, totalAmount, pageStatus, canConfirm, canCancel, minimumAmount, error}) {
    return OrderState(
      order: order ?? this.order,
      totalAmount: totalAmount ?? this.totalAmount,
      pageStatus: pageStatus ?? this.pageStatus,
      canConfirm: canConfirm ?? this.canConfirm,
      canCancel: canCancel ?? this.canCancel,
      minimumAmount: minimumAmount ?? this.minimumAmount,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [order, totalAmount, pageStatus, canConfirm, canCancel, minimumAmount, error];
}

enum OrderPageStatus {
  init,
  loading,
  loaded,
  confirmError,
}
