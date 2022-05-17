import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';

class Repository {
  Repository({required this.apiClient, required this.authService});

  ApiClient apiClient;
  AuthService authService;
  UserDto? _userDto;
  OrderDto? _orderDto;

  User? get user => _userDto?.toModel();

  Order? get order {
    _orderDto?.items.removeWhere((element) => element.id == 0);

    return _orderDto?.toModel();
  }

  Future<void> fetchAll() async {
    Map<String, String> body;
    var jwt = authService.jwt?.value;
    var username = authService.username;
    var password = authService.password;

    if (jwt != null && username != null && password != null) {
      body = {
        'usuario': username,
        'password': password,
        'fechaPedido': '',
        'token': jwt,
      };

      var json = await apiClient.post(path: 'all', body: body);

      _userDto = UserDto.fromJson(json['mdoConsumidor']);
      _orderDto = OrderDto.fromJson(json['mdoPedidosExtras']);
    }

    return Future.value(null);
  }
}