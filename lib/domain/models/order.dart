import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({required this.items, required this.date, required this.deliveryGroup});

  final List<OrderItem> items;
  final String date;
  final String deliveryGroup;

  static const empty = Order(items: [], date: '', deliveryGroup: '');

  @override
  List<Object> get props => [items, date, deliveryGroup];
}
