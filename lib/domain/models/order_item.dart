import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  const OrderItem({required this.id, required this.name, required this.price, required this.quantity});

  final int id;
  final String name;
  final double price;
  final int quantity;

  @override
  List<Object> get props => [id, name, price, quantity];
}