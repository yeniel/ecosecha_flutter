import 'dart:async';

import 'package:data/data.dart';

class Repository {
  Repository({required this.apiClient, required this.authRepository});

  ApiClient apiClient;
  AuthRepository authRepository;
  UserDto? userDto;
  CompanyDto? companyDto;
  OrderDto? orderDto;
  List<OrderHistoryDto>? orderHistoryDtoList;
  List<ProductDto>? basketDtoList;
  List<ProductDto>? extraDtoList;
  List<ProductDto>? productDtoList;
  List<FamilyDto>? familyDtoList;
  List<BasketProductDto>? basketProductDtoList;

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
    userDto = UserDto.fromJson(json['mdoConsumidor']);
  }

  void _setCompanyDto(Map<String, dynamic> json) {
    companyDto = CompanyDto.fromJson(json['mdoConfiguracion']);
  }

  void _setOrderDto(Map<String, dynamic> json) {
    orderDto = OrderDto.fromJson(json['mdoPedidosExtras']);
  }

  void _setBasketDtoList(Map<String, dynamic> json) {
    var basketsJson = json['mdoProductosCambios'];

    if (basketsJson != null && basketsJson is List<dynamic>) {
      basketDtoList = basketsJson.map((e) {
        return ProductDto.fromJson(e);
      }).toList();
    }
  }

  void _setExtraDtoList(Map<String, dynamic> json) {
    var extrasJson = json['mdoProductosExtras'];

    if (extrasJson != null && extrasJson is List<dynamic>) {
      extraDtoList = extrasJson.map((e) {
        return ProductDto.fromJson(e);
      }).toList();
    }
  }

  void _setFamilyDtoList(Map<String, dynamic> json) {
    var familiesJson = json['mdoFamilias'];

    if (familiesJson != null && familiesJson is List<dynamic>) {
      familyDtoList = familiesJson.map((e) {
        return FamilyDto.fromJson(e);
      }).toList();
    }
  }

  void _setProductDtoList(Map<String, dynamic> json) {
    productDtoList = (basketDtoList ?? []) + (extraDtoList ?? []);
  }

  void _setBasketProductDtoList(Map<String, dynamic> json) {
    var basketProductsJson = json['mdoComposicionCesta'];

    if (basketProductsJson != null && basketProductsJson is List<dynamic>) {
      basketProductDtoList = basketProductsJson.map((e) {
        return BasketProductDto.fromJson(e);
      }).toList();
    }
  }

  void _setOrderHistoryDtoList(Map<String, dynamic> json) {
    var orderHistoryJson = json['mdoFechasPedidosAnterior'];

    if (orderHistoryJson != null && orderHistoryJson is List<dynamic>) {
      orderHistoryDtoList = orderHistoryJson.map((e) {
        return OrderHistoryDto.fromJson(e);
      }).toList();
    }
  }
}
