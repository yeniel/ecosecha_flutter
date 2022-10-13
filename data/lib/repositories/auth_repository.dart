import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';

class AuthRepository {
  AuthRepository({required this.apiClient});

  ApiClient apiClient;

  JwtDto? _jwtDto;
  String? _username;
  String? _password;

  final _controller = StreamController<AuthenticationStatus>();

  void dispose() {
    _controller.close();
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
        var jwtFromSharedPreferences = Prefs.getString(Prefs.jwtKey);

        if (jwtFromSharedPreferences != null) {
          _jwtDto = JwtDto(value: jwtFromSharedPreferences);
        }
      }

      return _jwtDto;
  }

  String? get username {
    if (_username == null) {
      var usernameFromSharedPreferences = Prefs.getString(Prefs.usernameKey);

      if (usernameFromSharedPreferences != null) {
        _username = usernameFromSharedPreferences;
      }
    }

    return _username;
  }

  String? get password {
    if (_password == null) {
      var passwordFromSharedPreferences = Prefs.getString(Prefs.passwordKey);

      if (passwordFromSharedPreferences != null && passwordFromSharedPreferences.isNotEmpty) {
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
      if (error is ExpiredToken || error is ApiError) {
        throw InvalidCredentials();
      }

      throw ApiError();
    });
  }

  Future<void> renewToken() async {
    if (username != null && password != null) {
      await login(username: username!, password: password!);
    }

    return Future.error({});
  }

  void logout() {
    Prefs.setString(Prefs.passwordKey, '');
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void _saveJwt(json) {
    _jwtDto = JwtDto.fromJson(json);

    var jwtValue = _jwtDto?.value;

    if (jwtValue != null) {
      Prefs.setString(Prefs.jwtKey, jwtValue);
    }
  }

  void _saveUsername(username) {
    _username = username;
    Prefs.setString(Prefs.usernameKey, username);
  }

  void _savePassword(password) {
    _password = password;
    Prefs.setString(Prefs.passwordKey, password);
  }
}
