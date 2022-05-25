part of 'products_bloc.dart';

class ProductsState extends Equatable {
  ProductsState({required this.category, this.products = const []});

  final ProductCategory category;
  final List<Product> products;

  ProductsState copyWith({List<Product>? products}) {
    return ProductsState(category: category, products: products ?? []);
  }

  @override
  List<Object> get props => [products];
}
