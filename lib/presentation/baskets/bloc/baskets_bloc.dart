import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'baskets_event.dart';

part 'baskets_state.dart';

class BasketsBloc extends Bloc<BasketsEvent, BasketsState> {
  BasketsBloc({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(const BasketsState()) {
    on<BasketsInitEvent>(_onBasketsInit);
  }

  final ProductsRepository _productsRepository;

  void _onBasketsInit(BasketsInitEvent event, Emitter<BasketsState> emit) {
    var baskets = _productsRepository.baskets;

    emit(state.copyWith(products: baskets));
  }
}
