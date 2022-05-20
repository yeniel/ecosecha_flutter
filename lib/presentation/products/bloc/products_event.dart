part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class ProductsRequestedEvent extends ProductsEvent {
  const ProductsRequestedEvent();

  @override
  List<Object> get props => [];
}

class CategorySelectedEvent extends ProductsEvent {
  const CategorySelectedEvent({required this.selectedCategory});

  final ProductCategory selectedCategory;

  @override
  List<Object?> get props => [];
}

class BackToCategoriesEvent extends ProductsEvent {
  const BackToCategoriesEvent();

  @override
  List<Object?> get props => [];
}

