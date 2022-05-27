import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.basketId,
    required this.name,
    required this.price,
    required this.origin,
    required this.image,
    required this.measureUnit,
    required this.type,
    required this.categoryId,
  });

  final int id;
  final String basketId;
  final String name;
  final double price;
  final String origin;
  final String image;
  final String measureUnit;
  final ProductType type;
  final int categoryId;

  static Product empty({ProductType type = ProductType.basket, String image = ''}) {
    return Product(
      id: 0,
      basketId: '0',
      name: '',
      price: 0.0,
      origin: '',
      image: image,
      measureUnit: '',
      type: type,
      categoryId: 0,
    );
  }

  @override
  List<Object> get props => [id, basketId, name, price, origin, image, measureUnit, type, categoryId];
}
