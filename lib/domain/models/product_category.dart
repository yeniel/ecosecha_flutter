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

  static ProductCategory empty() {
    return const ProductCategory(id: 0, name: '', family: 0, icon: '');
  }

  @override
  List<Object> get props => [id, name, family];
}
