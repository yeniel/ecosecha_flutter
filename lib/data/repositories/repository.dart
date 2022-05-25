import 'dart:async';

import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';

class Repository {
  Repository({required this.apiClient, required this.authRepository});

  ApiClient apiClient;
  AuthRepository authRepository;
  UserDto? _userDto;
  OrderDto? _orderDto;
  List<ProductDto>? _basketDtoList;
  List<ProductDto>? _extraDtoList;
  List<ProductDto>? _productDtoList;
  List<FamilyDto>? _familyDtoList;
  List<BasketProductDto>? _basketProductDtoList;

  User? get user => Mappers.toUser(userDto: _userDto);

  Order? get order {
    if (_orderDto != null && _userDto != null && _productDtoList != null) {
      _orderDto!.products.removeWhere((element) => element.id == 0);

      return Mappers.toOrder(
        orderDto: _orderDto!,
        userDto: _userDto!,
        productDtoList: _productDtoList!,
      );
    }

    return null;
  }

  List<Product> get products => (baskets ?? []) + (extras ?? []);

  List<Product>? get baskets {
    if (_basketDtoList != null) {
      return Mappers.toProductList(productDtoList: _basketDtoList!);
    }

    return null;
  }

  List<Product>? get extras {
    if (_extraDtoList != null) {
      return Mappers.toProductList(productDtoList: _extraDtoList!);
    }

    return null;
  }

  List<ProductCategory>? get categories {
    if (_familyDtoList != null) {
      return Mappers.toCategoryMenuItemList(familyDtoList: _familyDtoList!);
    }

    return null;
  }

  List<Product> getProductsOfCategory(ProductCategory category) {
    return extras?.where((product) => product.categoryId == category.id).toList() ?? [];
  }

  List<BasketProduct>? getProductsOfBasket(Product basket) {
    var _productDtoList = _basketProductDtoList?.where((element) => element.basketId == basket.basketId).toList();

    if (_productDtoList != null) {
      return Mappers.toBasketProductList(basketProductDtoList: _productDtoList);
    }

    return null;
  }

  Future<void> fetchAll() async {
    Map<String, String> body;
    var jwt = authRepository.jwt?.value;
    var username = authRepository.username;
    var password = authRepository.password;

    if (jwt != null && username != null && password != null) {
      body = {
        'usuario': username,
        'password': password,
        'fechaPedido': '',
        'token': jwt,
      };

      return apiClient.post(path: 'all', body: body).then((json) {
        _setUserDto(json);
        _setOrderDto(json);
        _setBasketDtoList(json);
        _setExtraDtoList(json);
        _setFamilyDtoList(json);
        _setProductDtoList(json);
        _setBasketProductDtoList(json);
      }).catchError((error) async {
        if (error is ExpiredToken) {
          await authRepository.renewToken();
          unawaited(fetchAll());
        }
      });
    }

    return Future.value(null);
  }

  void _setUserDto(Map<String, dynamic> json) {
    _userDto = UserDto.fromJson(json['mdoConsumidor']);
  }

  void _setOrderDto(Map<String, dynamic> json) {
    _orderDto = OrderDto.fromJson(json['mdoPedidosExtras']);
  }

  void _setBasketDtoList(Map<String, dynamic> json) {
    var basketsJson = json['mdoProductosCambios'];

    if (basketsJson != null && basketsJson is List<dynamic>) {
      _basketDtoList = basketsJson.map((e) {
        return ProductDto.fromJson(e);
      }).toList();
    }
  }

  void _setExtraDtoList(Map<String, dynamic> json) {
    var extrasJson = json['mdoProductosExtras'];

    if (extrasJson != null && extrasJson is List<dynamic>) {
      _extraDtoList = extrasJson.map((e) {
        return ProductDto.fromJson(e);
      }).toList();
    }
  }

  void _setFamilyDtoList(Map<String, dynamic> json) {
    var familiesJson = json['mdoFamilias'];

    if (familiesJson != null && familiesJson is List<dynamic>) {
      _familyDtoList = familiesJson.map((e) {
        return FamilyDto.fromJson(e);
      }).toList();
    }
  }

  void _setProductDtoList(Map<String, dynamic> json) {
    _productDtoList = (_basketDtoList ?? []) + (_extraDtoList ?? []);
  }

  void _setBasketProductDtoList(Map<String, dynamic> json) {
    var basketProductsJson = json['mdoComposicionCesta'];

    if (basketProductsJson != null && basketProductsJson is List<dynamic>) {
      _basketProductDtoList = basketProductsJson.map((e) {
        return BasketProductDto.fromJson(e);
      }).toList();
    }
  }
}
