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

  static Product? toProduct({required ProductDto? productDto}) {
    if (productDto != null) {
      var productType = ProductType.extra;

      if (productDto.family == '1' && productDto.category == '23') {
        productType = ProductType.basket;
      }

      return Product(
        id: productDto.id,
        description: productDto.description,
        price: productDto.price,
        origin: productDto.origin,
        image: 'http://pedidos.ecosecha.org/imagenes/${productDto.image}',
        measureUnit: productDto.measureUnit,
        type: productType,
      );
    } else {
      return null;
    }
  }

  static List<Product>? toProductList({required List<ProductDto>? productDtoList}) {
    if (productDtoList != null) {
      return productDtoList.map((productDto) {
        return toProduct(productDto: productDto);
      }).whereType<Product>().toList();
    } else {
      return null;
    }
  }

  static Order? toOrder({
    required OrderDto? orderDto,
    required UserDto? userDto,
    required List<ProductDto>? productDtoList,
  }) {
    if (orderDto != null && userDto != null) {
      var products = orderDto.products.map((orderProductDto) {
        var productDto = productDtoList?.firstWhere((productDto) => productDto.id == orderProductDto.id);

        return toOrderProduct(orderProductDto: orderProductDto, productDto: productDto);
      });

      return Order(
        products: products.whereType<OrderProduct>().toList(),
        date: orderDto.date,
        deliveryGroup: userDto.deliveryGroup,
      );
    } else {
      return null;
    }
  }

  static OrderProduct? toOrderProduct({required OrderProductDto? orderProductDto, required ProductDto? productDto}) {
    var product = toProduct(productDto: productDto);

    if (orderProductDto != null && product != null) {
      return OrderProduct(
        product: product,
        quantity: orderProductDto.quantity.toInt(),
      );
    } else {
      return null;
    }
  }
}
