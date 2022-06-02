import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  AuthRepository({required this.apiClient}) {
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
    var name = username;
    var pass = password;

    if (jwt != null) {
      yield AuthenticationStatus.authenticated;
    } else if (name != null && pass != null) {
      await login(username: name, password: pass);
    } else {
      yield AuthenticationStatus.unauthenticated;
    }

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
      _saveJwt(json);
      _saveUsername(username);
      _savePassword(password);
      _controller.add(AuthenticationStatus.authenticated);
    }).catchError((error) {
      if (error is ApiError) {
        throw InvalidCredentials();
      }
    });
  }

  Future<void> renewToken() async {
    if (username != null && password != null) {
      await login(username: username!, password: password!);
    }

    return Future.error({});
  }

  void logout() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void _saveJwt(json) {
    _jwtDto = JwtDto.fromJson(json);

    var jwtValue = _jwtDto?.value;

    if (jwtValue != null) {
      _prefs?.setString(jwtKey, jwtValue);
    }
  }

  void _saveUsername(username) {
    _username = username;
    _prefs?.setString(usernameKey, username);
  }

  void _savePassword(password) {
    _password = password;
    _prefs?.setString(passwordKey, password);
  }
}
