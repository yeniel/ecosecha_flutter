import 'package:bloc/bloc.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'baskets_event.dart';

part 'baskets_state.dart';

class BasketsBloc extends Bloc<BasketsEvent, BasketsState> {
  BasketsBloc({required Repository repository})
      : _repository = repository,
        super(const BasketsState()) {
    on<BasketsRequestedEvent>(_onBasketsRequested);
  }

  final Repository _repository;

  void _onBasketsRequested(BasketsRequestedEvent event, Emitter<BasketsState> emit) {
    var baskets = _repository.baskets;

    emit(state.copyWith(products: baskets));
  }
}
