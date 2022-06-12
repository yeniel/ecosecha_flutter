import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class OrderProduct extends Equatable {
  const OrderProduct({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  static const OrderProduct empty = OrderProduct(product: Product.empty, quantity: 0);

  OrderProduct copyWith({product, quantity}) {
    return OrderProduct(product: product ?? this.product, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object> get props => [product, quantity];
}