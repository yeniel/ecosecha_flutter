import 'package:domain/domain.dart';

class LoginErrorEvent implements AnalyticsEvent {
  LoginErrorEvent({required this.error});

  @override
  String get name => AnalyticsEventName.loginError;

  late final String error;

  @override
  Map<String, dynamic> get properties => {'error': error};
}