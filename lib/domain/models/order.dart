import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({required this.products, required this.date, required this.deliveryGroup});

  final List<OrderProduct> products;
  final String date;
  final String deliveryGroup;

  static const empty = Order(products: [], date: '', deliveryGroup: '');

  @override
  List<Object> get props => [products, date, deliveryGroup];
}
