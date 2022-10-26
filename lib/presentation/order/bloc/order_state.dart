part of 'order_bloc.dart';

class OrderState extends Equatable {
  OrderState({
    this.order = Order.empty,
    this.totalAmount = 0.0,
    this.pageStatus = OrderPageStatus.init,
    this.canConfirm = true,
    this.canCancel = true,
    this.minimumAmount = 0,
    this.isAnonymousLogin = false,
    this.error = '',
    this.toggleState = true,
  });

  final Order order;
  final double totalAmount;
  final OrderPageStatus pageStatus;
  final bool canConfirm;
  final bool canCancel;
  final int minimumAmount;
  final bool isAnonymousLogin;
  final String error;
  final bool toggleState;

  OrderState copyWith({
    order,
    totalAmount,
    pageStatus,
    canConfirm,
    canCancel,
    minimumAmount,
    isAnonymousLogin,
    error,
    toggleState,
  }) {
    return OrderState(
      order: order ?? this.order,
      totalAmount: totalAmount ?? this.totalAmount,
      pageStatus: pageStatus ?? this.pageStatus,
      canConfirm: canConfirm ?? this.canConfirm,
      canCancel: canCancel ?? this.canCancel,
      minimumAmount: minimumAmount ?? this.minimumAmount,
      isAnonymousLogin: isAnonymousLogin ?? this.isAnonymousLogin,
      error: error ?? this.error,
      toggleState: toggleState ?? this.toggleState,
    );
  }

  @override
  List<Object> get props => [order, totalAmount, pageStatus, canConfirm, canCancel, minimumAmount, error, toggleState];
}

enum OrderPageStatus {
  init,
  loading,
  confirmationOk,
  confirmationError,
  canNotChangeError,
  isAnonymousLoginError,
}
