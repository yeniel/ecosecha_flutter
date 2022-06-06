import 'package:data/data.dart';
import 'package:data/dtos/order_product_cache_dto.dart';
import 'package:domain/domain.dart';

class OrderRepository {
  const OrderRepository({
    required this.apiClient,
    required this.repository,
    required this.productsRepository,
    required this.cacheDataSource,
  });

  final ApiClient apiClient;
  final Repository repository;
  final ProductsRepository productsRepository;
  final OrderCacheDataSource cacheDataSource;

  Future<Order> get order async {
    Order orderInApi = _orderInApi();
    Order? orderInCache = await _orderInCache();

    return orderInCache ?? orderInApi;
  }

  Order _orderInApi() {
    if (repository.orderDto != null && repository.userDto != null && repository.productDtoList != null) {
      _removeEmptyMaps();

      return Mappers.toOrder(
        orderDto: repository.orderDto!,
        userDto: repository.userDto!,
        productDtoList: repository.productDtoList!,
      );
    } else {
      return Order.empty;
    }
  }

  // BACKEND API BUG
  void _removeEmptyMaps() {
    repository.orderDto!.products.removeWhere((element) => element.id == 0);
  }

  Future<Order?> _orderInCache() async {
    List<OrderProductCacheDto> orderProductCacheDtoList = await cacheDataSource.getProducts();

    if (orderProductCacheDtoList.isNotEmpty) {
      List<OrderProduct> orderProducts = orderProductCacheDtoList.map((cacheProduct) {
        var product = productsRepository.products.firstWhere((product) => product.id == cacheProduct.id);

        return OrderProduct(product: product, quantity: cacheProduct.quantity);
      }).toList();

      return _orderInApi().copyWith(newProducts: orderProducts);
    }

    return null;
  }

  Future<bool> get hasOrderInCache async {
    Order orderInApi = _orderInApi();
    Order? orderInCache = await _orderInCache();

    return orderInApi != orderInCache;
  }

  void updateOrder({required Order order}) {
    for (var orderProduct in order.products) {
      cacheDataSource.upsertProduct(orderProduct: Mappers.toOrderProductCacheDto(orderProduct: orderProduct));
    }
  }

  Future<bool> confirmOrder() {
    cacheDataSource.deleteAll();

    return Future.value(true);
  }

  void addOrUpdateProduct({required OrderProduct orderProduct}) {
    cacheDataSource.upsertProduct(orderProduct: Mappers.toOrderProductCacheDto(orderProduct: orderProduct));
  }

  void deleteProduct({required OrderProduct orderProduct}) {
    cacheDataSource.deleteProduct(id: orderProduct.product.id);
  }

  List<Order>? get orderHistory {
    if (repository.orderHistoryDtoList != null) {
      return Mappers.toOrderHistoryList(orderHistoryDtoList: repository.orderHistoryDtoList!);
    }

    return null;
  }
}
