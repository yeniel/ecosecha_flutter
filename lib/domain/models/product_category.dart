import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable {
  const ProductCategory({
    required this.id,
    required this.name,
    required this.family,
    required this.icon,
  });

  final int id;
  final String name;
  final int family;
  final String icon;

  @override
  List<Object> get props => [id, name, family];
}
