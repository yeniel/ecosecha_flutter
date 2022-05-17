import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required Repository repository})
      : _repository = repository,
        super(OrderState(order: Order.empty)) {
    on<OrderRequestedEvent>(_onOrderRequested);
  }

  final Repository _repository;

  void _onOrderRequested(OrderRequestedEvent event, Emitter<OrderState> emit) {
    var order = _repository.order;

    emit(state.copyWith(order: order));
  }
}
