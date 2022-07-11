import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.codigo,
    required this.name,
    required this.price,
    required this.origin,
    required this.image,
    required this.measureUnit,
    required this.type,
    required this.category,
    required this.family,
  });

  final int id;
  final String name;
  final double price;
  final String origin;
  final String image;
  final String measureUnit;
  final ProductType type;
  final int category;
  final int family;
  final String codigo; // No sé para que es este campo pero lo he añadido para poder hacer
  // el post de confirmar pedido

  static const Product empty = Product(
    id: 0,
    codigo: '0',
    name: '',
    price: 0.0,
    origin: '',
    image: '',
    measureUnit: '',
    type: ProductType.basket,
    category: 0,
    family: 0,
  );

  static const Product emptyWithDefaultImage = Product(
    id: 0,
    codigo: '0',
    name: '',
    price: 0.0,
    origin: '',
    image: Constants.productDefaultImage,
    measureUnit: '',
    type: ProductType.basket,
    category: 0,
    family: 0
  );

  @override
  List<Object> get props => [id, codigo, name, price, origin, image, measureUnit, type, category];
}
