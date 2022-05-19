import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.description,
    required this.price,
    required this.origin,
    required this.image,
    required this.measureUnit,
    required this.type
  });

  final int id;
  final String description;
  final double price;
  final String origin;
  final String image;
  final String measureUnit;
  final ProductType type;

  @override
  List<Object> get props => [id, description, price, origin, image, measureUnit, type];
}
