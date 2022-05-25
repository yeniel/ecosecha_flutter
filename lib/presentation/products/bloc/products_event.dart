part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class ProductsRequestedEvent extends ProductsEvent {
  const ProductsRequestedEvent();

  @override
  List<Object?> get props => [];
}
