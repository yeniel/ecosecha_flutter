import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required ProductsRepository productsRepository,
    required OrderRepository orderRepository,
    ProductCategory? category,
  })  : _productsRepository = productsRepository,
        _orderRepository = orderRepository,
        _category = category ?? ProductCategory.empty(),
        super(ProductsState(category: category ?? ProductCategory.empty())) {
    on<ProductsInitEvent>(_onProductsInit);
  }

  final ProductsRepository _productsRepository;
  final OrderRepository _orderRepository;
  final ProductCategory _category;

  Future<void> _onProductsInit(ProductsInitEvent event, Emitter<ProductsState> emit) async {
    await emit.forEach<Order>(
      _orderRepository.order,
      onData: (order) {
        var orderProducts = _productsRepository.getProductsOfCategory(_category).map((basket) {
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
