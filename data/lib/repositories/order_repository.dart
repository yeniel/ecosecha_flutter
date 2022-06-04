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

  Order? get order {
    Order? currentOrder;

    if (repository.orderDto != null && repository.userDto != null && repository.productDtoList != null) {
      // THIS IS BECAUSE WE RECEIVE SOME EMPTY MAPS
      repository.orderDto!.products.removeWhere((element) => element.id == 0);

      currentOrder = Mappers.toOrder(
        orderDto: repository.orderDto!,
        userDto: repository.userDto!,
        productDtoList: repository.productDtoList!,
      );
    }

    List<String>? savedOrderProductIds = sharedPreferences.getStringList(orderProductIdsKey);

    if (currentOrder != null && savedOrderProductIds != null) {
      List<Product> products = productsRepository.products.where((product) =>
          savedOrderProductIds.contains(product.id.toString())).toList();

      return currentOrder.copyWith(newProducts: products);
    } else {
      return currentOrder;
    }

    return null;
  }

  void updateOrder({required Order order}) {
    List<String> newOrderProductIds = order.products.map((orderProduct) => orderProduct.product.id.toString()).toList();

    sharedPreferences.setStringList(orderProductIdsKey, newOrderProductIds);
  }

  Future<bool> confirmOrder() {
    sharedPreferences.remove(orderProductIdsKey);

    return Future.value(true);
  }

  List<Order>? get orderHistory {
    if (repository.orderHistoryDtoList != null) {
      return Mappers.toOrderHistoryList(orderHistoryDtoList: repository.orderHistoryDtoList!);
    }

    return null;
  }
}
