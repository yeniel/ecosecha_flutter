part of 'products_bloc.dart';

class ProductsState extends Equatable {
  ProductsState({required this.category, this.orderProducts = const []});

  final ProductCategory category;
  final List<OrderProduct> orderProducts;

  ProductsState copyWith({required products}) {
    return ProductsState(category: category, orderProducts: products);
  }

  @override
  List<Object> get props => [orderProducts];
}
