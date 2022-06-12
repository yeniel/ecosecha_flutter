part of 'product_quantity_bloc.dart';

abstract class ProductQuantityEvent extends Equatable {
  const ProductQuantityEvent();
}

class ProductQuantityInitEvent extends ProductQuantityEvent {
  const ProductQuantityInitEvent();

  @override
  List<Object?> get props => [];
}

class AddProductEvent extends ProductQuantityEvent {
  const AddProductEvent({required this.orderProduct});

  final OrderProduct orderProduct;

  @override
  List<Object?> get props => [orderProduct];
}

class SubtractProductEvent extends ProductQuantityEvent {
  const SubtractProductEvent({required this.orderProduct});

  final OrderProduct orderProduct;

  @override
  List<Object?> get props => [orderProduct];
}

class DeleteProductEvent extends ProductQuantityEvent {
  const DeleteProductEvent({required this.orderProduct});

  final OrderProduct orderProduct;

  @override
  List<Object?> get props => [orderProduct];
}
