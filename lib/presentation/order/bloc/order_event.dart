part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class OrderInitEvent extends OrderEvent {
  const OrderInitEvent();

  @override
  List<Object?> get props => [];
}

class AddProductEvent extends OrderEvent {
  const AddProductEvent({required this.orderProduct});

  final OrderProduct orderProduct;

  @override
  List<Object?> get props => [orderProduct];
}

class SubtractProductEvent extends OrderEvent {
  const SubtractProductEvent({required this.orderProduct});

  final OrderProduct orderProduct;

  @override
  List<Object?> get props => [orderProduct];
}

class DeleteProductEvent extends OrderEvent {
  const DeleteProductEvent({required this.orderProduct});

  final OrderProduct orderProduct;

  @override
  List<Object?> get props => [orderProduct];
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

class OrderSignInEvent extends OrderEvent {
  const OrderSignInEvent();

  @override
  List<Object?> get props => [];
}

class OrderSignUpEvent extends OrderEvent {
  const OrderSignUpEvent();

  @override
  List<Object?> get props => [];
}
