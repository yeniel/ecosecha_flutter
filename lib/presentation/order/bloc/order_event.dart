part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class OrderRequestedEvent extends OrderEvent {
  const OrderRequestedEvent();

  @override
  List<Object?> get props => [];
}
