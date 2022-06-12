part of 'product_quantity_bloc.dart';

class ProductQuantityState extends Equatable {
  const ProductQuantityState({orderProduct}) : orderProduct = orderProduct ?? OrderProduct.empty;

  final OrderProduct orderProduct;

  ProductQuantityState copyWith({orderProduct}) {
    return ProductQuantityState(orderProduct: orderProduct);
  }

  @override
  List<Object> get props => [];
}
