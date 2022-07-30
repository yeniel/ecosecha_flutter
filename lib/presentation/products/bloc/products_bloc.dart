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
    on<ProductsSearchEvent>(_onProductsSearch);
  }

  final ProductsRepository _productsRepository;
  final OrderRepository _orderRepository;
  final ProductCategory _category;
  List<OrderProduct> _allProducts = [];

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

        _allProducts = orderProducts;

        return state.copyWith(products: orderProducts);
      },
      onError: (_, __) => state,
    );
  }

  Future<void> _onProductsSearch(ProductsSearchEvent event, Emitter<ProductsState> emit) async {
    var filteredProducts = _allProducts.where((element) {
      var productName = element.product.name.toLowerCase();

      return productName.contains(event.query);
    }).toList();

    emit(state.copyWith(products: filteredProducts));
  }
}
