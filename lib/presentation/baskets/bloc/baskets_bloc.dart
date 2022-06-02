import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'baskets_event.dart';

part 'baskets_state.dart';

class BasketsBloc extends Bloc<BasketsEvent, BasketsState> {
  BasketsBloc({required Repository repository})
      : _repository = repository,
        super(const BasketsState()) {
    on<BasketsInitEvent>(_onBasketsRequested);
  }

  final Repository _repository;

  void _onBasketsRequested(BasketsInitEvent event, Emitter<BasketsState> emit) {
    var baskets = _repository.baskets;

    emit(state.copyWith(products: baskets));
  }
}
