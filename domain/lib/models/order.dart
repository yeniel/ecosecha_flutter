import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({required this.products, required this.date, required this.deliveryGroup});

  final List<OrderProduct> products;
  final String date;
  final String deliveryGroup;

  static const empty = Order(products: [], date: '', deliveryGroup: '');

  Order copyWith({newProducts}) {
    return Order(products: newProducts ?? products, date: date, deliveryGroup: deliveryGroup);
  }

  @override
  List<Object> get props => [products, date, deliveryGroup];
}
