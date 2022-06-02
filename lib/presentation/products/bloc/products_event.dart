part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class ProductsInitEvent extends ProductsEvent {
  const ProductsInitEvent();

  @override
  List<Object?> get props => [];
}
