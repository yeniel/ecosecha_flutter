import 'dart:async';

import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/data/repositories/api_errors.dart';
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

  User? get user => Mappers.toUser(userDto: _userDto);

  Order? get order {
    _orderDto?.products.removeWhere((element) => element.id == 0);

    return Mappers.toOrder(
      orderDto: _orderDto,
      userDto: _userDto,
      productDtoList: _productDtoList,
    );
  }

  List<Product>? get products => (baskets ?? []) + (extras ?? []);

  List<Product>? get baskets {
    return Mappers.toProductList(productDtoList: _basketDtoList);
  }

  List<Product>? get extras {
    return Mappers.toProductList(productDtoList: _extraDtoList);
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
        _userDto = UserDto.fromJson(json['mdoConsumidor']);
        _orderDto = OrderDto.fromJson(json['mdoPedidosExtras']);

        var basketsJson = json['mdoProductosCambios'];

        if (basketsJson != null && basketsJson is List<dynamic>) {
          _basketDtoList = basketsJson.map((e) {
            return ProductDto.fromJson(e);
          }).toList();
        }

        var extrasJson = json['mdoProductosExtras'];

        if (extrasJson != null && extrasJson is List<dynamic>) {
          _extraDtoList = extrasJson.map((e) {
            return ProductDto.fromJson(e);
          }).toList();
        }

        _productDtoList = (_basketDtoList ?? []) + (_extraDtoList ?? []);
      }).catchError((error) async {
        if (error is ExpiredToken) {
          await authRepository.renewToken();
          unawaited(fetchAll());
        }
      });
    }

    return Future.value(null);
  }
}
