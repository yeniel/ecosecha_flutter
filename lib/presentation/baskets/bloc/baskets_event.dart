part of 'baskets_bloc.dart';

abstract class BasketsEvent extends Equatable {
  const BasketsEvent();
}

class BasketsInitEvent extends BasketsEvent {
  const BasketsInitEvent();

  @override
  List<Object?> get props => [];
}
