part of 'baskets_bloc.dart';

abstract class BasketsState extends Equatable {
  const BasketsState();
}

class BasketsInitial extends BasketsState {
  @override
  List<Object> get props => [];
}
