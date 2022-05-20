import 'dart:io';

import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:ecosecha_flutter/presentation/utils/extensions.dart';
import 'package:path/path.dart';

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
        name: productDto.name,
        price: productDto.price,
        origin: productDto.origin,
        image: _getProductImageUrl(productDto),
        measureUnit: productDto.measureUnit,
        type: productType,
        categoryId: int.parse(productDto.category),
      );
    } else {
      return null;
    }
  }

  static _getProductImageUrl(ProductDto productDto) {
    var imageUrl = 'http://pedidos.ecosecha.org/imagenes/';

    if (productDto.image.isEmpty) {
      imageUrl = 'http://pedidos.ecosecha.org/img/default.jpg';
    } else if (productDto.image.startsWith('/')) {
      var file = File(productDto.image);

      imageUrl += basename(file.path);
    } else {
      imageUrl += productDto.image;
    }

    return imageUrl;
  }

  static List<Product> toProductList({required List<ProductDto> productDtoList}) {
    return productDtoList
        .map((productDto) {
          return toProduct(productDto: productDto);
        })
        .whereType<Product>()
        .toList();
  }

  static Order? toOrder({
    required OrderDto orderDto,
    required UserDto userDto,
    required List<ProductDto> productDtoList,
  }) {
    var products = orderDto.products.map((orderProductDto) {
      var productDto = productDtoList.firstWhere((productDto) => productDto.id == orderProductDto.id);

      return toOrderProduct(orderProductDto: orderProductDto, productDto: productDto);
    });

    return Order(
      products: products.whereType<OrderProduct>().toList(),
      date: orderDto.date,
      deliveryGroup: userDto.deliveryGroup,
    );
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

  static List<ProductCategory> toCategoryMenuItemList({required List<FamilyDto> familyDtoList}) {
    return familyDtoList
        .map((familyDto) {
          return familyDto.categories
              .map((categoryDto) {
                return toCategoryMenuItem(categoryDto: categoryDto, familyId: familyDto.id);
              })
              .whereType<ProductCategory>()
              .toList();
        })
        .expand((element) => element.toList())
        .whereType<ProductCategory>()
        .toList();
  }

  static ProductCategory? toCategoryMenuItem({required CategoryDto categoryDto, required int familyId}) {
    return ProductCategory(
      id: categoryDto.id,
      name: categoryDto.name.capitalizeWords,
      family: familyId,
      icon: _getIconName(categoryDto.id),
    );
  }

  static String _getIconName(int categoryId) {
    switch (categoryId) {
      case 1:
        return 'fruit';
      case 4:
        return 'rice';
      case 18:
        return 'canned';
      case 12:
        return 'breakfast';
      case 11:
        return 'cold_meat';
      case 19:
        return 'egg';
      case 3:
        return 'legume';
      case 13:
        return 'bread';
      case 24:
        return 'vegetable';
      default:
        return 'none';
    }
  }
}
