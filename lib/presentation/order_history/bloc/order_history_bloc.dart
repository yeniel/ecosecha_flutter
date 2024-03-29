import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'order_history_event.dart';

part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc({
    required OrderRepository orderRepository,
    required AnalyticsManager analyticsManager,
  })  : _orderRepository = orderRepository,
        _analyticsManager = analyticsManager,
        super(const OrderHistoryState()) {
    on<OrderHistoryEvent>(_onOrderHistoryInitEvent);
  }

  final OrderRepository _orderRepository;
  final AnalyticsManager _analyticsManager;

  void _onOrderHistoryInitEvent(OrderHistoryEvent event, Emitter<OrderHistoryState> emit) {
    var orderHistory = _orderRepository.orderHistory;

    if (orderHistory != null) {
      emit(state.copyWith(orders: orderHistory));
    }

    _analyticsManager.logEvent(OrderHistoryPageEvent());
  }
}
