import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class OrderProduct extends Equatable {
  const OrderProduct({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  @override
  List<Object> get props => [product, quantity];
}