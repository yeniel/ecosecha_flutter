part of 'products_bloc.dart';

class ProductsState extends Equatable {
  ProductsState({this.categories = const [], this.selectedCategory, this.products = const []});

  final List<ProductCategory> categories;
  final ProductCategory? selectedCategory;
  final List<Product> products;

  ProductsState copyWith({
    List<ProductCategory>? categories,
    ProductCategory? selectedCategory,
    List<Product>? products,
  }) {
    return ProductsState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory,
      products: products ?? [],
    );
  }

  @override
  List<Object> get props => [categories, products];
}
