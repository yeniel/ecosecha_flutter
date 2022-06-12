import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'product_quantity_event.dart';
part 'product_quantity_state.dart';

class ProductQuantityBloc extends Bloc<ProductQuantityEvent, ProductQuantityState> {
  ProductQuantityBloc({required OrderProduct orderProduct, required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(ProductQuantityState(orderProduct: orderProduct)) {
    on<AddProductEvent>(_onAddProduct);
    on<SubtractProductEvent>(_onSubtractProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  final OrderRepository _orderRepository;

  Future<void> _onAddProduct(AddProductEvent event, Emitter<ProductQuantityState> emit) async {
    var orderProduct = event.orderProduct.copyWith(quantity: event.orderProduct.quantity + 1);

    _orderRepository.addOrUpdateProduct(orderProduct: orderProduct);
    emit(state.copyWith(orderProduct: event.orderProduct));
  }

  Future<void> _onSubtractProduct(SubtractProductEvent event, Emitter<ProductQuantityState> emit) async {
    var orderProduct = event.orderProduct.copyWith(quantity: event.orderProduct.quantity - 1);

    _orderRepository.addOrUpdateProduct(orderProduct: orderProduct);
    emit(state.copyWith(orderProduct: event.orderProduct));
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductQuantityState> emit) async {
    _orderRepository.deleteProduct(orderProduct: event.orderProduct);
    emit(state.copyWith(orderProduct: event.orderProduct));
  }
}
