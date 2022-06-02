part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();
}

class OrderHistoryInitEvent extends OrderHistoryEvent {
  const OrderHistoryInitEvent();

  @override
  List<Object?> get props => [];
}
