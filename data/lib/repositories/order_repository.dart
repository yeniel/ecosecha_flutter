import 'package:data/data.dart';
import 'package:domain/domain.dart';

class OrderRepository {
  const OrderRepository({required this.repository});

  final Repository repository;

  Order? get order {
    if (repository.orderDto != null && repository.userDto != null && repository.productDtoList != null) {
      repository.orderDto!.products.removeWhere((element) => element.id == 0);

      return Mappers.toOrder(
        orderDto: repository.orderDto!,
        userDto: repository.userDto!,
        productDtoList: repository.productDtoList!,
      );
    }

    return null;
  }

  List<Order>? get orderHistory {
    if (repository.orderHistoryDtoList != null) {
      return Mappers.toOrderHistoryList(orderHistoryDtoList: repository.orderHistoryDtoList!);
    }

    return null;
  }
}