part of 'baskets_bloc.dart';

abstract class BasketsEvent extends Equatable {
  const BasketsEvent();
}

class BasketsRequestedEvent extends BasketsEvent {
  const BasketsRequestedEvent();

  @override
  List<Object?> get props => [];
}
