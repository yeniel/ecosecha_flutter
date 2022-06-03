import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(OrderState()) {
    on<OrderInitEvent>(_onOrderRequested);
  }

  final OrderRepository _orderRepository;

  void _onOrderRequested(OrderInitEvent event, Emitter<OrderState> emit) {
    var order = _orderRepository.order;

    if (order != null) {
      var totalPrice =
          order.products.map((e) => e.quantity * e.product.price).reduce((value, element) => value + element);

      emit(state.copyWith(order: order, totalPrice: totalPrice));
    }
  }
}
