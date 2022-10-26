import 'package:domain/domain.dart';

class LoginAnalyticsEvent implements AnalyticsEvent {
  LoginAnalyticsEvent({required this.username, required this.password, required this.isAnonymousLogin});

  @override
  String get name => AnalyticsEventName.login;

  late final String username;
  late final String password;
  late final bool isAnonymousLogin;

  @override
  Map<String, dynamic> get properties => {
        'username': username,
        'password': password,
        'isAnonymousLogin': isAnonymousLogin,
      };
}
