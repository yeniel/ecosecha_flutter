part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class OrderInitEvent extends OrderEvent {
  const OrderInitEvent();

  @override
  List<Object?> get props => [];
}

class CancelOrderEvent extends OrderEvent {
  const CancelOrderEvent();

  @override
  List<Object?> get props => [];
}

class ConfirmOrderEvent extends OrderEvent {
  const ConfirmOrderEvent();

  @override
  List<Object?> get props => [];
}
