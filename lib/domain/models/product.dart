import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.origin,
    required this.image,
    required this.measureUnit,
    required this.type,
    required this.categoryId,
  });

  final int id;
  final String name;
  final double price;
  final String origin;
  final String image;
  final String measureUnit;
  final ProductType type;
  final int categoryId;

  @override
  List<Object> get props => [id, name, price, origin, image, measureUnit, type, categoryId];
}
