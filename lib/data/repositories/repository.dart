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
  List<OrderHistoryDto>? _orderHistoryDtoList;
  CompanyDto? _companyDto;

  User? get user => Mappers.toUser(userDto: _userDto);

  Company? get company => Mappers.toCompany(companyDto: _companyDto);

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

  List<Order>? get orderHistory {
    if (_orderHistoryDtoList != null) {
      return Mappers.toOrderHistoryList(orderHistoryDtoList: _orderHistoryDtoList!);
    }

    return null;
  }

  List<Product> getProductsOfCategory(ProductCategory category) {
    return extras?.where((product) => product.categoryId == category.id).toList() ?? [];
  }

  List<BasketProduct>? getProductsOfBasket(Product basket) {
    var _productDtoList = _basketProductDtoList?.where((element) => element.basketId == basket.basketId).toList();

    if (_productDtoList != null) {
      return Mappers.toBasketProductList(basketProductDtoList: _productDtoList, productList: products);
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
        _setOrderHistoryDtoList(json);
        _setCompanyDto(json);
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

  void _setCompanyDto(Map<String, dynamic> json) {
    _companyDto = CompanyDto.fromJson(json['mdoConfiguracion']);
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

  void _setOrderHistoryDtoList(Map<String, dynamic> json) {
    var orderHistoryJson = json['mdoFechasPedidosAnterior'];

    if (orderHistoryJson != null && orderHistoryJson is List<dynamic>) {
      _orderHistoryDtoList = orderHistoryJson.map((e) {
        return OrderHistoryDto.fromJson(e);
      }).toList();
    }
  }
}
