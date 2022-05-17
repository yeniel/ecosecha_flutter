import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({required this.items, required this.date});

  final List<OrderItem> items;
  final String date;

  static const empty = Order(items: [], date: '');

  @override
  List<Object> get props => [items, date];
}
