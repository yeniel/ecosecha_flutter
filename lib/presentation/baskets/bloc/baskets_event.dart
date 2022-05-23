part of 'baskets_bloc.dart';

abstract class BasketsEvent extends Equatable {
  const BasketsEvent();
}

class BasketsRequestedEvent extends BasketsEvent {
  const BasketsRequestedEvent();

  @override
  List<Object?> get props => [];
}

class BasketTapEvent extends BasketsEvent {
  const BasketTapEvent({required this.basket});

  final Product basket;

  @override
  List<Object?> get props => [basket];
}

class BackToBasketsEvent extends BasketsEvent {
  const BackToBasketsEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
