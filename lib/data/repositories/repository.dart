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

  User? get user => Mappers.toUser(userDto: _userDto);

  Order? get order {
    _orderDto?.items.removeWhere((element) => element.id == 0);

    return Mappers.toOrder(orderDto: _orderDto, userDto: _userDto);
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