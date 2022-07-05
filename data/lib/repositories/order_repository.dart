import 'package:data/data.dart';
import 'package:domain/domain.dart';

// ignore: depend_on_referenced_packages
import "package:rxdart/rxdart.dart";

class OrderRepository {
  OrderRepository({
    required this.apiClient,
    required this.repository,
    required this.productsRepository,
  }) {
    _orderInMemory = _getOrderInApi();
    _orderStreamController.add(_orderInMemory);
  }

  final ApiClient apiClient;
  final Repository repository;
  final ProductsRepository productsRepository;

  final _orderStreamController = BehaviorSubject<Order>.seeded(Order.empty);
  Order _orderInMemory = Order.empty;

  Stream<Order> get order => _orderStreamController.asBroadcastStream();

  bool isConfirmed = true;

  List<Order>? get orderHistory {
    if (repository.orderHistoryDtoList != null) {
      return Mappers.toOrderHistoryList(orderHistoryDtoList: repository.orderHistoryDtoList!);
    }

    return null;
  }

  Future<bool> confirmOrder() {
    isConfirmed = true;

    return Future.value(true);
  }

  void addOrUpdateProduct({required OrderProduct orderProduct}) {
    int savedOrderProductIndex =
        _orderInMemory.products.indexWhere((element) => element.product == orderProduct.product);

    if (savedOrderProductIndex == -1) {
      _orderInMemory.products.add(orderProduct);
    } else {
      _orderInMemory.products[savedOrderProductIndex] = orderProduct;
    }

    _emitOrderChange();
  }

  void deleteProduct({required OrderProduct orderProduct}) {
    _orderInMemory.products.removeWhere((element) => element.product == orderProduct.product);

    _emitOrderChange();
  }

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

  void _emitOrderChange() {
    isConfirmed = _getOrderInApi() == _orderInMemory || _orderInMemory.products.isEmpty;
    _orderStreamController.add(_orderInMemory);
  }
}
