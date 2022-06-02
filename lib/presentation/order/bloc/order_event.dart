part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class OrderInitEvent extends OrderEvent {
  const OrderInitEvent();

  @override
  List<Object?> get props => [];
}
