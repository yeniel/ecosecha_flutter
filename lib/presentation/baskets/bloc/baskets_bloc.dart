import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'baskets_event.dart';

part 'baskets_state.dart';

class BasketsBloc extends Bloc<BasketsEvent, BasketsState> {
  BasketsBloc({required ProductsRepository productsRepository, required OrderRepository orderRepository})
      : _productsRepository = productsRepository,
        _orderRepository = orderRepository,
        super(const BasketsState()) {
    on<BasketsInitEvent>(_onBasketsInit);
  }

  final ProductsRepository _productsRepository;
  final OrderRepository _orderRepository;

  Future<void> _onBasketsInit(BasketsInitEvent event, Emitter<BasketsState> emit) async {
    await emit.forEach<Order>(
      _orderRepository.order,
      onData: (order) {
        var orderProducts = _productsRepository.baskets?.map((basket) {
          return order.products.firstWhere(
            (orderProduct) => orderProduct.product.id == basket.id,
            orElse: () => OrderProduct(product: basket, quantity: 0),
          );
        }).toList();

        return state.copyWith(products: orderProducts);
      },
      onError: (_, __) => state,
    );
  }
}
