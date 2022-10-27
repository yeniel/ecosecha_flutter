import 'package:domain/domain.dart';

class LoginErrorEvent implements AnalyticsEvent {
  LoginErrorEvent({required this.error, required this.isAnonymousLogin});

  @override
  String get name => AnalyticsEventName.loginError;

  late final String error;
  late final bool isAnonymousLogin;

  @override
  Map<String, dynamic> get properties => {
        'error': error,
        'isAnonymousLogin': isAnonymousLogin,
      };
}
