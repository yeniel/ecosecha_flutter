import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc({required Repository repository}) : _repository = repository, super(const OrderHistoryState()) {
    on<OrderHistoryEvent>(_onOrderHistoryInitEvent);
  }

  final Repository _repository;

  void _onOrderHistoryInitEvent(OrderHistoryEvent event, Emitter<OrderHistoryState> emit) {
    var orderHistory = _repository.orderHistory;

    if (orderHistory != null) {
      emit(state.copyWith(orders: orderHistory));
    }
  }
}
