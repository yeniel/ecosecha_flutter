import 'package:data/data.dart';
import 'package:domain/domain.dart';
// ignore: depend_on_referenced_packages
import "package:rxdart/rxdart.dart";

class OrderRepository {
  OrderRepository({
    required this.apiClient,
    required this.repository,
    required this.productsRepository,
    required this.cacheDataSource,
  }) {
    Order orderInApi = _getOrderInApi();

    _getOrderInCache().then((orderInCache) {
      _orderInCache = orderInCache;
      _orderStreamController.add(orderInCache ?? orderInApi);
    });
  }

  final ApiClient apiClient;
  final Repository repository;
  final ProductsRepository productsRepository;
  final OrderCacheDataSource cacheDataSource;

  final _orderStreamController = BehaviorSubject<Order>.seeded(Order.empty);
  late Order? _orderInCache;

  Stream<Order> get order => _orderStreamController.asBroadcastStream();

  Order _getOrderInApi() {
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

  Future<Order?> _getOrderInCache() async {
    List<OrderProductCacheDto> orderProductCacheDtoList = await cacheDataSource.getProducts();

    if (orderProductCacheDtoList.isNotEmpty) {
      List<OrderProduct> orderProducts = orderProductCacheDtoList.map((cacheProduct) {
        var product = productsRepository.products.firstWhere((product) => product.id == cacheProduct.id);

        return OrderProduct(product: product, quantity: cacheProduct.quantity);
      }).toList();

      return _getOrderInApi().copyWith(newProducts: orderProducts);
    }

    return null;
  }

  void _emitOrder() {
    _getOrderInCache().then((orderInCache) {
      _orderInCache = orderInCache;

      if (_orderInCache != null) {
        _orderStreamController.add(orderInCache!);
      }
    });
  }

  bool get isConfirmed {
    Order orderInApi = _getOrderInApi();

    return orderInApi != _orderInCache;
  }

  void updateOrder({required Order order}) {
    for (var orderProduct in order.products) {
      cacheDataSource.upsertProduct(orderProduct: Mappers.toOrderProductCacheDto(orderProduct: orderProduct));
    }

    _emitOrder();
  }

  Future<bool> confirmOrder() {
    cacheDataSource.deleteAll();

    return Future.value(true);
  }

  void addOrUpdateProduct({required OrderProduct orderProduct}) {
    cacheDataSource.upsertProduct(orderProduct: Mappers.toOrderProductCacheDto(orderProduct: orderProduct));
    _emitOrder();
  }

  void deleteProduct({required OrderProduct orderProduct}) {
    cacheDataSource.deleteProduct(id: orderProduct.product.id);
    _emitOrder();
  }

  List<Order>? get orderHistory {
    if (repository.orderHistoryDtoList != null) {
      return Mappers.toOrderHistoryList(orderHistoryDtoList: repository.orderHistoryDtoList!);
    }

    return null;
  }
}
