import 'package:equatable/equatable.dart';

class BasketProduct extends Equatable {
  BasketProduct({
    required this.quantity,
    required this.basketId,
    required this.name,
    required this.origin,
  });

  final int quantity;
  final int basketId;
  final String name;
  final String origin;

  @override
  List<Object> get props => [quantity, basketId, name, origin];
}