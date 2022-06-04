import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  const OrderRepository({
    required this.apiClient,
    required this.repository,
    required this.productsRepository,
    required this.sharedPreferences,
  });

  final ApiClient apiClient;
  final Repository repository;
  final ProductsRepository productsRepository;
  final SharedPreferences sharedPreferences;

  Order get order {
    Order orderInApi = _orderInApi();
    Order? orderInCache = _orderInCache();

    return orderInCache ?? orderInApi;
  }

  Order _orderInApi() {
    if (repository.orderDto != null && repository.userDto != null && repository.productDtoList != null) {
      // THIS IS BECAUSE WE RECEIVE SOME EMPTY MAPS
      repository.orderDto!.products.removeWhere((element) => element.id == 0);

      return Mappers.toOrder(
        orderDto: repository.orderDto!,
        userDto: repository.userDto!,
        productDtoList: repository.productDtoList!,
      );
    } else {
      return Order.empty;
    }
  }

  Order? _orderInCache() {
    List<String>? savedOrderProductIdList = sharedPreferences.getStringList(orderProductIdListKey);

    if (savedOrderProductIdList != null) {
      List<Product> products = productsRepository.products.where((product) =>
          savedOrderProductIdList.contains(product.id.toString())).toList();

      return _orderInApi().copyWith(newProducts: products);
    }

    return null;
  }

  bool get hasOrderInCache {
    return _orderInCache() != null;
  }

  void updateOrder({required Order order}) {
    List<String> newOrderProductIdList = order.products.map((orderProduct) => orderProduct.product.id.toString()).toList();

    sharedPreferences.setStringList(orderProductIdListKey, newOrderProductIdList);
  }

  Future<bool> confirmOrder() {
    sharedPreferences.remove(orderProductIdListKey);

    return Future.value(true);
  }

  void addProduct({required Product product}) {
    List<String>? cacheOrderProductIdList = sharedPreferences.getStringList(orderProductIdListKey);

    if (cacheOrderProductIdList != null) {
      cacheOrderProductIdList.add(product.id.toString());
      sharedPreferences.setStringList(orderProductIdListKey, cacheOrderProductIdList);
    }
  }

  void removeProduct({required Product product}) {
    List<String>? cacheOrderProductIdList = sharedPreferences.getStringList(orderProductIdListKey);

    if (cacheOrderProductIdList != null) {
      cacheOrderProductIdList.remove(product.id.toString());
      sharedPreferences.setStringList(orderProductIdListKey, cacheOrderProductIdList);
    }
  }

  List<Order>? get orderHistory {
    if (repository.orderHistoryDtoList != null) {
      return Mappers.toOrderHistoryList(orderHistoryDtoList: repository.orderHistoryDtoList!);
    }

    return null;
  }
}
