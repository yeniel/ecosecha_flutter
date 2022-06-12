import 'package:domain/domain.dart';
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

  static const Product empty = Product(
    id: 0,
    basketId: '0',
    name: '',
    price: 0.0,
    origin: '',
    image: '',
    measureUnit: '',
    type: ProductType.basket,
    categoryId: 0,
  );

  static const Product emptyWithDefaultImage = Product(
    id: 0,
    basketId: '0',
    name: '',
    price: 0.0,
    origin: '',
    image: Constants.productDefaultImage,
    measureUnit: '',
    type: ProductType.basket,
    categoryId: 0,
  );

  @override
  List<Object> get props => [id, basketId, name, price, origin, image, measureUnit, type, categoryId];
}
