import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:path/path.dart';

class Mappers {
  static User? toUser({required UserDto? userDto}) {
    if (userDto != null) {
      var firstEmail = userDto.emails.first.replaceAll('\n', '');

      return User(
        id: userDto.id,
        name: userDto.name,
        email: firstEmail,
        deliveryGroup: userDto.deliveryGroup,
        orderWarning: userDto.orderWarning,
      );
    } else {
      return null;
    }
  }

  static Company? toCompany({required CompanyDto? companyDto}) {
    if (companyDto != null) {
      var address = '${companyDto.address} ${companyDto.town} ${companyDto.zip} ${companyDto.province}';

      return Company(
        blogUrl: companyDto.blogUrl.trim(),
        cif: companyDto.cif.trim(),
        email: companyDto.email.trim(),
        address: address.trim(),
        name: companyDto.name.trim(),
        phone: companyDto.phone.trim(),
        ordersWebUrl: companyDto.webUrl.trim().replaceAll('www.', ''),
        minimumAmount: int.parse(companyDto.minimumAmount.trim()),
      );
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
        codigo: productDto.codigo,
        name: productDto.name,
        price: productDto.price,
        origin: productDto.origin,
        image: _getProductImageUrl(productDto),
        measureUnit: productDto.measureUnit,
        type: productType,
        category: int.parse(productDto.category),
        family: int.parse(productDto.family),
      );
    } else {
      return null;
    }
  }

  static _getProductImageUrl(ProductDto productDto) {
    var imageUrl = 'http://pedidos.ecosecha.org/imagenes/';
    var imageBasename = '';

    if (productDto.image.startsWith('/')) {
      var file = File(productDto.image);

      imageBasename = basename(file.path);
    } else {
      imageBasename = productDto.image;
    }

    if (imageBasename.isEmpty) {
      imageUrl = Constants.productDefaultImage;
    } else {
      imageUrl += imageBasename.replaceAll(' ', '%20');
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

  static Order toOrder({
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

  static String _getIconName(int category) {
    switch (category) {
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
      case 8:
        return 'juice';
      default:
        return 'none';
    }
  }

  static List<BasketProduct> toBasketProductList({
    required List<BasketProductDto> basketProductDtoList,
    required List<Product> productList,
  }) {
    return basketProductDtoList.map((basketProductDto) {
      var relatedProduct = _getRelatedProduct(basketProductDto: basketProductDto, productList: productList);

      return BasketProduct(
        quantity: int.parse(basketProductDto.quantity),
        basketId: int.parse(basketProductDto.basketId),
        name: basketProductDto.name,
        origin: basketProductDto.origin,
        product: relatedProduct,
      );
    }).toList();
  }

  static Product _getRelatedProduct({required BasketProductDto basketProductDto, required List<Product> productList}) {
    var basketProductNameWords = basketProductDto.name.split(' ').map((e) => e.toLowerCase());

    basketProductNameWords = _sanitizeBasketProductNameWords(basketProductNameWords: basketProductNameWords.toList());

    var productsMatchWithBasketProductNameFirstWord = productList.where((product) {
      return product.name.toLowerCase().contains(basketProductNameWords.first);
    }).toList();

    var wordCounter = 0;
    var max = 0;
    var selectedProduct = Product.emptyWithDefaultImage;

    if (productsMatchWithBasketProductNameFirstWord.isNotEmpty) {
      selectedProduct = productsMatchWithBasketProductNameFirstWord.first;
    }

    for (var product in productsMatchWithBasketProductNameFirstWord) {
      var productNameWords = product.name.split(' ').map((e) => e.toLowerCase());

      for (var word in productNameWords) {
        if (basketProductNameWords.contains(word)) {
          wordCounter++;
        }
      }

      if (wordCounter > max) {
        max = wordCounter;
        selectedProduct = product;
      }

      wordCounter = 0;
    }

    return selectedProduct;
  }

  static List<String> _sanitizeBasketProductNameWords({required List<String> basketProductNameWords}) {
    var wrongNames = {
      'berenejsna': 'berenjena',
      'berenejena': 'berenjena'
    };

    return basketProductNameWords.map((name) {
      if (wrongNames.keys.contains(name)) {
        return wrongNames[name] ?? name;
      }

      return name;
    }).toList();

  }

  static List<Order> toOrderHistoryList({required List<OrderHistoryDto> orderHistoryDtoList}) {
    return orderHistoryDtoList.map((orderHistoryDto) {
      return Order(
        products: const [],
        date: orderHistoryDto.date,
        deliveryGroup: '',
      );
    }).toList();
  }
}
