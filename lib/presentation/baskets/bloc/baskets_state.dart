part of 'baskets_bloc.dart';

class BasketsState extends Equatable {
  BasketsState({this.baskets = const []});

  final List<Product> baskets;

  BasketsState copyWith({List<Product>? baskets}) {
    return BasketsState(baskets: baskets ?? []);
  }

  @override
  List<Object> get props => [baskets];
}
