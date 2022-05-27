import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

class BasketProduct extends Equatable {
  BasketProduct({
    required this.quantity,
    required this.basketId,
    required this.name,
    required this.origin,
    required this.product,
  });

  final int quantity;
  final int basketId;
  final String name;
  final String origin;
  final Product product;

  @override
  List<Object> get props => [quantity, basketId, name, origin, product];
}