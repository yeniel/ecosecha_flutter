part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class ProductsInitEvent extends ProductsEvent {
  const ProductsInitEvent();

  @override
  List<Object?> get props => [];
}

class ProductsSearchEvent extends ProductsEvent {
  const ProductsSearchEvent({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}