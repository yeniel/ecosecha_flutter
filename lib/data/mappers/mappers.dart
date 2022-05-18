import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';

class Mappers {
  static User? toUser({required UserDto? userDto}) {
    if (userDto != null) {
      var firstEmail = userDto.emails.first.replaceAll('\n', '');

      return User(id: userDto.id, name: userDto.name, email: firstEmail);
    } else {
      return null;
    }
  }

  static Order? toOrder({required OrderDto? orderDto, required UserDto? userDto}) {
    if (orderDto != null && userDto != null) {
      return Order(
        items: orderDto.items.map((e) => toOrderItem(orderItemDto: e)).whereType<OrderItem>().toList(),
        date: orderDto.date,
        deliveryGroup: userDto.deliveryGroup,
      );
    } else {
      return null;
    }
  }

  static OrderItem? toOrderItem({required OrderItemDto? orderItemDto}) {
    if (orderItemDto != null) {
      return OrderItem(
        id: orderItemDto.id,
        name: orderItemDto.name,
        quantity: orderItemDto.quantity.toInt(),
        price: orderItemDto.price,
      );
    } else {
      return null;
    }
  }
}
