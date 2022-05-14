import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class Repository {
  Repository({required this.apiClient, required this.authService});

  ApiClient apiClient;
  AuthService authService;
  UserDto? _userDto;

  User? get user => _userDto?.toModel();

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
    }

    return Future.value(null);
  }


}