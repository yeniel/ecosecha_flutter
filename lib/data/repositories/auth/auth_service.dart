import 'dart:async';

import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class AuthService {
  AuthService({required this.apiClient}) {
    _initSharedPreferences();
  }

  ApiClient apiClient;

  JwtDto? _jwtDto;
  String? _username;
  String? _password;

  SharedPreferences? _prefs;
  final _controller = StreamController<AuthenticationStatus>();

  void dispose() {
    _controller.close();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  JwtDto? get jwt {
      if (_jwtDto == null) {
        var jwtFromSharedPreferences = _prefs?.getString(jwtKey);

        if (_prefs != null && jwtFromSharedPreferences != null) {
          _jwtDto = JwtDto(value: jwtFromSharedPreferences);
        }
      }

      return _jwtDto;
  }

  String? get username {
    if (_username == null) {
      var usernameFromSharedPreferences = _prefs?.getString(usernameKey);

      if (_prefs != null && usernameFromSharedPreferences != null) {
        _username = usernameFromSharedPreferences;
      }
    }

    return _username;
  }

  String? get password {
    if (_password == null) {
      var passwordFromSharedPreferences = _prefs?.getString(passwordKey);

      if (_prefs != null && passwordFromSharedPreferences != null) {
        _password = passwordFromSharedPreferences;
      }
    }

    return _password;
  }

  Future<void> login({required String username, required String password}) {
    var body = {'usuario': username, 'password': password};

    return apiClient.post(path: 'loginuser', body: body).then((json) {
      _jwtDto = JwtDto.fromJson(json);
      _username = username;
      _password = password;
      _controller.add(AuthenticationStatus.authenticated);
    });
  }

  void logout() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }
}
